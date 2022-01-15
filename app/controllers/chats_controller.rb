class ChatsController < ApplicationController
  # before_action :set_chat, only: %i[show update destroy]

  def index
    chats = Chat.joins(:application).select(:number).where(application: { token: params[:token] }).as_json(except: :id)
    render json: chats
  end

  def show; end

  def create
    @application = Application.find_by(token: params[:token])

    @chat = @application.chats.new

    if @chat.save
      render json: { status: 200, message: 'created chat successfully', data: {number: @chat.number} }
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
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
