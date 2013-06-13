class ChatController < ApplicationController
  def index
    render :index
  end

  def incoming
    message = Message.create(:nick => params[:nick], :message => params[:message])
    render :json => {}
  end

  def outgoing
    render :json => Message.where(["id > ?", params[:last_id]]).order("created_at ASC, id ASC")
  end
end
