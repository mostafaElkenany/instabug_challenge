class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[show update destroy]

  def index
    @applications = Application.select('token', 'name', 'chats_count').as_json(except: :id)

    render json: { status: 200, message: 'fetched applications successfully', data: @applications }
  end

  def show
    render json: { status: 200, message: 'fetched application successfully', data: @application }
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      render json: { status: 200, message: 'application created successfully',
                     data: { name: @application.name, token: @application.token } }
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def update
    if @application.update(application_params)
      render json: { status: 200, message: 'application updated successfully',
                     data: { name: @application.name, token: @application.token } }
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @application.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_application
    @application = Application.select('token', 'name',
                                      'chats_count').find_by(token: params[:token]).as_json(except: :id)
  end

  # Only allow a list of trusted parameters through.
  def application_params
    params.require(:application).permit(:name)
  end
end
