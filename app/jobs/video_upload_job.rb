class VideoUploadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Cloudinary.config do |config|
      config.cloud_name = 'hemu3z3fr'
      config.api_key = '841439911225851'
      config.api_secret = 'dWCAE_1WB8iTVZIbjYjviX-O3-c'
      config.secure = true
    end

    video_dir = "public/streams/"

    [".ts",".m3u8"].each do |file_type|
      video_files = Dir[video_dir + file_type].sort

      video_files.each do |raw_video|
        file_path = CGI.escape(
              raw_video.gsub(file_type,"").gsub("public/streams/","streams/")
        ).gsub(".","~") + file_type

        Cloudinary::Uploader.upload_large(
          raw_video, resource_type: :video, public_id: file_path
        )
      end
    end
  end
end
