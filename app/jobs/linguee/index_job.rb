class Linguee::IndexJob < ApplicationJob
  queue_as :default

  @@base_url = "https://www.linguee.de"

  @@url_list = %w[
    https://www.linguee.de/german-english/topgerman/1-200.html
    https://www.linguee.de/german-english/topgerman/201-1000.html
    https://www.linguee.de/german-english/topgerman/1001-2000.html
  ]

  def perform(*args)
    show_urls = []

    reset_windscribe()

    @@url_list.each do |cur_url|
      cur_html = Nokogiri::HTML(
        HTTParty.get(cur_url).body
      )

      show_urls += cur_html.css('table a').map(&:values).map(&:first)
    end

    show_urls.map! { |s| s.prepend@@base_url }

    show_urls.each do |show_url|
      sleep 1.5 * rand()
      Linguee::ShowJob.perform_now show_url
    end
  end
end
