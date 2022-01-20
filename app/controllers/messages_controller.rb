class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update]

  def index
    if params[:query]
      chat = Chat.joins(:application).find_by(application: { token: params[:token] }, number: params[:chat_number].to_i)
      response = []
      unless chat.nil?
        search_result = Message.search(params[:query], chat.id)
        response = search_result.map do |res|
          { content: res[:_source][:content], number: res[:_source][:number] }
        end
      end
    else
      response = Message.joins(chat: :application).select(:content, :number).where(chat: { number: params[:chat_number].to_i },
                                                                                   application: { token: params[:token] }).as_json(except: :id)
    end
    render json: response
  end

  def show
    unless @message.nil?
      render json: { content: @message.content, number: @message.number }
    else
      render json: { status: 400, message: 'message not found' }
    end
  end

  def create
    chat = Chat.joins(:application).find_by(application: { token: params[:token] }, number: params[:chat_number].to_i)

    if chat.messages.nil?
      number = 1
    else
      number = chat.messages.length
      number += 1
    end

    CreateMessageJob.perform_later(chat, message_params, number)
    render json: { status: 200, message: 'created message successfully', data: { number: number } }
  rescue StandardError => e
    render json: { status: 422, message: 'failed to create message', error: e }
  end

  def update
    if @message.update(message_params)
      render json: { content: @message.content, number: @message.number }
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { status: 422, message: 'failed to update message', error: e }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.joins(chat: :application).find_by(chat: { number: params[:chat_number].to_i },
                                                         application: { token: params[:token] }, number: params[:message_number])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content)
  end
end
