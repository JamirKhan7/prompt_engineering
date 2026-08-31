class Api::V1::MessagesController < ApplicationController
  def create
    conversation = Conversation.find_by(id: params[:conversation_id])

    user_message = params.require(:message)

    conversation.messages.create!(
      role: "user",
      content: user_message
    )

    # Ask AI
    response = PizzaBot::Chat
      .new(conversation)
      .call
    
    conversation.messages.create!(
      role: "assistant",
      content: response
    )

    render json: {
      message: response
    }
  end

  def index
    conversation = Conversation.find_by(id: params[:conversation_id])
    messages = conversation.messages.each do |message|
      {
        id: message.id,
        content: message.content,
        role: message.role
      }
    end
    render json: messages
  end
end
