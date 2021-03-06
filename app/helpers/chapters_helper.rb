module ChaptersHelper

  def markdown(text)
    Markdown.new(text).to_html.html_safe
  end

  def picture(chapter)
    chapter.picture ? chapter.picture : asset_path("default_pic.jpg")
  end

  def link_to_next(chapter)
    chapters = chapter.fanfic.chapters
    return nil unless next_chapter = chapters[chapter.number]
    link_to t("chapters.next"), fanfic_chapter_path(next_chapter.fanfic, next_chapter), class: "btn btn-secondary"
  end

  def link_to_previos(chapter)
    chapters = chapter.fanfic.chapters
    return nil if chapter.number == 1
    previous_chapter = chapters[chapter.number - 2]
    link_to t("chapters.prev"), fanfic_chapter_path(previous_chapter.fanfic, previous_chapter), class: "btn btn-secondary"
  end

  def chapter_pages(current_chapter)
    current_chapter.fanfic.chapters.map do |chapter|
      link_to chapter.number.to_s, fanfic_chapter_path(chapter.fanfic, chapter),
       class: (chapter == current_chapter ? "btn btn-secondary disabled" : "btn btn-secondary")
    end
  end

  def has_edit_asses?(fanfic)
    has_access?(fanfic.user_id) && fanfic.chapters.count > 1
  end

end
