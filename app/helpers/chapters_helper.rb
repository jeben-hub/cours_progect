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
    link_to "Next chapter", fanfic_chapter_path(next_chapter.fanfic, next_chapter), class: "nav-link"
  end

  def link_to_previos(chapter)
    chapters = chapter.fanfic.chapters
    return nil if chapter.number == 1
    previous_chapter = chapters[chapter.number - 2]
    link_to "Previous chapter", fanfic_chapter_path(previous_chapter.fanfic, previous_chapter), class: "nav-link"
  end

  def chapter_pages(current_chapter)
    current_chapter.fanfic.chapters.map do |chapter|
      link_to chapter.number.to_s, fanfic_chapter_path(chapter.fanfic, chapter),
       class: (chapter == current_chapter ? "nav-link disabled" : "nav-link")
    end
  end

  def has_edit_asses?(fanfic)
    has_access?(fanfic.user_id) && fanfic.chapters.count > 1
  end

end
