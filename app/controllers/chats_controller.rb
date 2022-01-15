class ChatsController < ApplicationController
  before_action only: %i[ show update destroy ]

  # GET /chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  def show
    @application = Application.find_by(token: params[:token])
    @chat = Chat.select('number').where(application_id: @application.id).as_json(:except => :id)
    render json: @chat
  end

  # POST /chats
  def create
    @application = Application.find_by(token: params[:token])
    
    @chat = Chat.new()
    @chat.application_id = @application.id
    # render json: {status: 200, message: 'fetched application successfully', data: @application}
    if @chat.save
      render json: {status: 200, message: 'created chat successfully', data: @chat}
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

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
