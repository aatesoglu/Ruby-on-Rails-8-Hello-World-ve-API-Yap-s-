class Api::V1::ResponsesController < ApplicationController
  before_action :set_response, only: %i[show update destroy]

  def index
    @responses = Response.all
    render json: @responses
  end

  def show
    render json: @response
  end

  def create
    @response = Response.new(response_params)
    if @response.save
      render json: @response, status: :created
    else
      render json: { errors: @response.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @response.update(response_params)
      render json: @response
    else
      render json: { errors: @response.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @response.destroy
    head :no_content
  end

  private

  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.require(:response).permit(
      :participant_id,
      :response_data,
      :completed_at,
      :survey_id
    )
  end
end