class Api::V1::ScalesController < ApplicationController
  before_action :set_scale, only: %i[show update destroy]

  def index
    @scales = Scale.all
    render json: @scales
  end

  def show
    render json: @scale
  end

  def create
    @scale = Scale.new(scale_params)
    if @scale.save
      render json: @scale, status: :created
    else
      render json: { errors: @scale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @scale.update(scale_params)
      render json: @scale
    else
      render json: { errors: @scale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @scale.destroy
    head :no_content
  end

  private

  def set_scale
    @scale = Scale.find(params[:id])
  end

  def scale_params
    params.require(:scale).permit(
      :title,
      :description,
      :doi_identifier,
      :version,
      :language,
      :category,
      :item_count,
      :metadata,
      :status,
      :user_id
    )
  end
end