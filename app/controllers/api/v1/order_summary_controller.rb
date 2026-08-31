class Api::V1::OrderSymmaryController < ApplicationController
  def create
    conversation = Conversation.find(params[:conversation_id])

    summary = OrderSummary
      .new(conversation)
      .call

    render json: JSON.parse(summary)
  end
end
