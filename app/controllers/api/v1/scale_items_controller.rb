class Api::V1::ScaleItemsController < ApplicationController
  before_action :set_scale_item, only: %i[show update destroy]

  def index
    @scale_items = ScaleItem.all
    render json: @scale_items
  end

  def show
    render json: @scale_item
  end

  def create
    @scale_item = ScaleItem.new(scale_item_params)
    if @scale_item.save
      render json: @scale_item, status: :created
    else
      render json: { errors: @scale_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @scale_item.update(scale_item_params)
      render json: @scale_item
    else
      render json: { errors: @scale_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @scale_item.destroy
    head :no_content
  end

  private

  def set_scale_item
    @scale_item = ScaleItem.find(params[:id])
  end

  def scale_item_params
    params.require(:scale_item).permit(
      :content,
      :item_type,
      :order,
      :options,
      :scale_id
    )
  end
end