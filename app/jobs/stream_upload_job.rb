class StreamUploadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Cloudinary.config do |config|
      config.cloud_name = 'hemu3z3fr'
      config.api_key = '841439911225851'
      config.api_secret = 'dWCAE_1WB8iTVZIbjYjviX-O3-c'
      config.secure = true
    end

    cloudinary_resources = []

    work_cursor = nil
    work_total = nil

    while work_total.nil? || (!work_cursor.nil?)
      cur_results = Cloudinary::Search.expression("resource_type:raw").max_results(500)
      cur_results = cur_results.next_cursor(work_cursor) unless work_cursor.nil?
      cur_results = cur_results.execute

      cloudinary_resources += cur_results["resources"]
      work_total = cur_results["total_count"]
      work_cursor = cur_results["next_cursor"]
    end

    init_file_names = Dir["public/streams/*"]
    work_file_names = init_file_names.dup

    missing_files = []

    cloudinary_resources.each do |cur_resource|
      work_public_id = "public/" + cur_resource['public_id']
      unless init_file_names.include? work_public_id
        missing_files += work_public_id
        next
      end
      raise 'hell' unless cur_resource["bytes"] == File.size(work_public_id)
      work_file_names.delete work_public_id
    end

    Parallel.map(work_file_names, in_threads: 32) do |cur_file|
      puts cur_file
      work_public_id = cur_file.gsub("public/","")
      Cloudinary::Uploader.upload(cur_file, public_id: work_public_id, overwrite: false, resource_type: "raw")
    end

    return
  end
end
