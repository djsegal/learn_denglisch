class Linguee::ShowJob < ApplicationJob
  queue_as :default

  @@base_url = "https://www.linguee.de"

  @@ignored_classes = %w[
    exact
    example_lines
    inexact
    more_example
    copyright_wrapper
    hidden
    copyrightLineOuter
  ]

  def perform(cur_url)
    cur_url = "https://www.linguee.de/deutsch-englisch/uebersetzung/mitarbeiter.html"
    puts cur_url

    word_html = nil
    max_attempts = 3
    attempt_count = 0

    while word_html.nil?
      reset_windscribe() \
        if attempt_count > 0

      cur_html = Nokogiri::HTML(
        HTTParty.get(cur_url).body
      )

      word_html = cur_html.css(".isMainTerm")[0]

      attempt_count += 1
      raise 'hell' if attempt_count > max_attempts
    end

    children_classes = word_html.children.map {
      |child_div| child_div['class'] \
    }.reject(&:nil?).map(&:split).flatten

    children_classes.each do |child_class|
      next if @@ignored_classes.include? child_class
      puts "Ignored: " + child_class
    end

    lemma_count = 0

    word_html.css(".exact .lemma.featured").each_with_index do |cur_lemma, lemma_index|
      next unless cur_lemma['class'] == "lemma featured"
      lemma_count += 1

      lemma_header = cur_lemma.css('h2')[0]

      header_children = lemma_header.children.select(&:element?).count

      lemma_plural = nil
      lemma_singular = nil

      lemma_is_other_plural = false

      if header_children == 3

        raw_lemma_plural = lemma_header.css(".forms_plural a")
        raw_lemma_singular = lemma_header.css(".forms_plural\\:rev .tag_s")

        if raw_lemma_plural.count == 0
          raw_lemma_plural = lemma_header.css(".forms_plural .tag_s")
          lemma_is_other_plural = true \
            if raw_lemma_plural.count > 0
        end

        if raw_lemma_plural.count > 0
          raise 'hell' if raw_lemma_singular.count > 0
          lemma_plural = raw_lemma_plural[0].text
        else
          raise 'hell' unless raw_lemma_singular.count == 1
          lemma_singular = raw_lemma_singular[0].text
        end
      else
        raise 'hell' unless header_children == 2
      end

      header_span = lemma_header.css(".tag_lemma")[0]

      lemma_name = header_span.css(".dictLink")[0].text

      if header_span.css(".tag_wordtype")[0].nil?
        lemma_type = "-"
      else
        lemma_type = header_span.css(".tag_wordtype")[0].text
      end

      lemma_audio = "public/mp3/" + lemma_name + "_"
      lemma_audio += (lemma_index+1).to_s + ".mp3"

      audio_url = @@base_url + "/mp3/" + header_span.css(
        ".audio"
        )[0]['onclick'].split('this,"')[-1].split('"')[0]

      Down.download audio_url, destination: lemma_audio
    end

    raise hell unless lemma_count > 0
  end
end
