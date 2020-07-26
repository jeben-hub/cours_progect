module FanficsHelper
  def all_tags(fanfic)
    fanfic.tags.map(&:name).map { |t| link_to t, tag_path(t), class: "btn btn-outline-secondary btn-sm" }.join(', ')
  end
end
