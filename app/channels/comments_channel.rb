class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from  "fanfic_" + params[:fanfic_id].to_s
  end

  def unsubscribed
  end
end
