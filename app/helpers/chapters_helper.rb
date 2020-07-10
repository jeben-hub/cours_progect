module ChaptersHelper

  def markdown(text)
    Markdown.new(text).to_html.html_safe
  end
  def picture(chapter)
    chapter.picture ? chapter.picture : asset_path("default_pic.jpg")
  end
end
