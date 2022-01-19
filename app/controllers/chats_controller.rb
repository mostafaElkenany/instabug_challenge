class ChatsController < ApplicationController
  # before_action :set_chat, only: %i[show update destroy]

  def index
    chats = Chat.joins(:application).select(:number,
                                            :messages_count).where(application: { token: params[:token] }).as_json(except: :id)
    render json: chats
  end

  def show; end

  def create
    application = Application.find_by(token: params[:token])
    if application.chats.nil?
      number = 1
    else
      number = application.chats.length
      number += 1
    end
    CreateChatJob.perform_later(application, number)
    render json: { status: 200, message: 'created chat successfully', data: { number: number } }
  rescue StandardError => e
    render json: { status: 422, message: 'failed to create chat' }
  end

  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_chat
  #   @chat = Chat.find(params[:token])
  # end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit([])
  end
end
