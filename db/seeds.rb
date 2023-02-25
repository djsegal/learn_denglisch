# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

video_dir = "public/streams/"

video_files = Dir[video_dir + "*_en.vtt"].sort

Video.destroy_all

video_files.each do |raw_video|
    video_name = raw_video
    video_name = video_name.gsub(video_dir, "")
    video_name = video_name.gsub("_en.vtt", "")

    file_path = CGI.escape(
        raw_video.gsub("_en.vtt","").gsub("public/streams/","streams/")
    ).gsub(".","~")

    season_number, episode_number = \
        video_name.match(/\[S(\d+)_E(\d+)\]/).captures.map(&:to_i)

    video_name = video_name.split("]")[-1].gsub(/\s+/, " ")

    Video.create!(
        name: video_name,
        season_number: season_number,
        episode_number: episode_number,
        file_path: file_path
    )
end
