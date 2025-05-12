# app/jobs/generate_posters_for_saga_job.rb
require 'mini_magick'
require 'rmagick'

class GeneratePostersForSagaJob < ApplicationJob
  queue_as :default

  def perform()
    saga = Saga.find_by(name: "Babylon Berlin")
    saga.videos.each do |video|
      poster_path = generate_episode_poster(
        video.season_number,
        video.episode_number,
        "public/streams/" + video.name + ".png"
      )
    end
  end

  private

  def generate_episode_poster(season, episode, image_path)
    label = "Staffel %02d\nFolge %02d" % [season, episode]
    ref_image = MiniMagick::Image.open(
      "public/[S00_E00] Poster.png"
    )
    width = ref_image.width
    height = ref_image.height

    # Create gray background image
    img = Magick::Image.new(width, height)
    img.erase!  # make it blank
    gray_fill = Magick::Draw.new
    gray_fill.fill('gray')
    gray_fill.rectangle(0, 0, width, height)
    gray_fill.draw(img)

    # Draw text
    draw = Magick::Draw.new
    draw.font_family = 'Arial'
    draw.pointsize = height / 4
    draw.fill = 'white'
    draw.gravity = Magick::CenterGravity
    draw.annotate(img, 0, 0, 0, 0, label)

    # Save poster to disk
    FileUtils.mkdir_p(File.dirname(image_path))
    img.write(image_path)
    puts "Saved poster to #{image_path}"
    image_path
  end
end
