class StreamUploadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Cloudinary.config do |config|
      config.cloud_name = 'hemu3z3fr'
      config.api_key = '841439911225851'
      config.api_secret = 'dWCAE_1WB8iTVZIbjYjviX-O3-c'
      config.secure = true
    end

    Dir["public/streams/*"].each do |cur_file|
      puts cur_file
      work_public_id = cur_file.gsub("public/","")
      Cloudinary::Uploader.upload(cur_file, public_id: work_public_id, overwrite: false, resource_type: "raw")
    end

    return
  end
end
