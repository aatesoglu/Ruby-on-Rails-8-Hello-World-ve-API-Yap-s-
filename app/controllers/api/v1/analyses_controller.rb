class Api::V1::AnalysesController < ApplicationController
  before_action :set_analysis, only: %i[show update destroy]

  def index
    @analyses = Analysis.all
    render json: @analyses
  end

  def show
    render json: @analysis
  end

  def create
    @analysis = Analysis.new(analysis_params)
    if @analysis.save
      render json: @analysis, status: :created
    else
      render json: { errors: @analysis.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @analysis.update(analysis_params)
      render json: @analysis
    else
      render json: { errors: @analysis.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @analysis.destroy
    head :no_content
  end

  private

  def set_analysis
    @analysis = Analysis.find(params[:id])
  end

  def analysis_params
    params.require(:analysis).permit(
      :analysis_type,
      :parameters,
      :results,
      :status,
      :credit_cost,
      :executed_at,
      :project_id,
      :survey_id
    )
  end
end