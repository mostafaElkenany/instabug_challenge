class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update destroy]

  def index
    @application = Application.find_by(token: params[:token])
    chat = @application.chats.detect do |chat|
      chat[:application_id] == @application.id and chat[:number] == params[:chat_number].to_i
    end

    response = chat.messages.map do |message|
      { number: message[:number], content: message[:content] }
    end
    render json: response
  end

  def show
    render json: @message
  end

  def create
    @application = Application.find_by(token: params[:token])
    @chat = Chat.find_by(application_id: @application.id, number: params[:chat_number])

    @message = Message.new(message_params)
    @message.chat_id = @chat.id

    if @message.save
      render json: { status: 200, message: 'created message successfully', data: @message }
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content)
  end
end
