class Api::V1::ConversationsController < ApplicationController
  def index
    conversations = Conversation
                      .order(updated_at: :desc)
    
    render json: conversations.map do |conversation|
      {
        id: conversation.id,
        title: conversation.title,
        created_at: conversation.created_at,
        updated_at: conversation.updated_at
      }
    end
  end

  def create
    conversation = Conversation.create!

    render json: {
      id: conversation.id
    }, status: :created
  end

  def destroy
    conversation = Conversation.find_by(id: params[:id])
    conversation.destroy! if conversation.present?

    head :no_content
  end
end
