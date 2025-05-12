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
Saga.destroy_all

kromer_saga = Saga.create! name: "Chez Krömer"
babylon_saga = Saga.create! name: "Babylon Berlin"

video_files.each do |raw_video|
    video_name = raw_video
    video_name = video_name.gsub(video_dir, "")
    video_name = video_name.gsub("_en.vtt", "")

    file_path = CGI.escape(
        raw_video.gsub("_en.vtt","").gsub("public/streams/","streams/")
    ).gsub(".","~")

    used_saga = nil
    used_match = nil

    first_match = video_name.match(/\[S(\d+)_E(\d+)\]/)
    second_match = video_name.match(/\-s(\d+)\-e(\d+)/)

    if first_match.present?
        used_saga = kromer_saga
        used_match = first_match
    elsif second_match.present?
        used_saga = babylon_saga
        used_match = second_match
    else
        puts(video_name)
        raise 'hell'
    end

    if used_saga.nil? or used_match.nil?
        raise 'hell'
    end

    season_number, episode_number = \
        used_match.captures.map(&:to_i)

    video_name = video_name.split("]")[-1].gsub(/\s+/, " ")

    Video.create!(
        name: video_name,
        season_number: season_number,
        episode_number: episode_number,
        file_path: file_path,
        saga: used_saga
    )
end
