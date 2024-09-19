class Linguee::AudioJob < ApplicationJob
  queue_as :default

  def perform(*args)
    reset_windscribe()

    Parallel.map(CSV.foreach("db/data/audio_list.txt"), progress: "Crawling...", in_threads: 12) do |cur_row|
      raise 'hell' if cur_row.length != 1

      audio_url = cur_row[0]
      translation_audio = "public/mp3/" + audio_url.sub("https://www.linguee.de/mp3/","")

      next if File.exists? translation_audio

      cur_dir = translation_audio.reverse.split('/', 2).map(&:reverse).reverse[0]
      FileUtils.mkdir_p cur_dir

      Down.download audio_url, destination: translation_audio
      sleep rand(0..3)
    end

  end
end
