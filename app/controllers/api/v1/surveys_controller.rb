class Api::V1::SurveysController < ApplicationController
  before_action :set_survey, only: %i[show update destroy]

  def index
    @surveys = Survey.all
    render json: @surveys
  end

  def show
    render json: @survey
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      render json: @survey, status: :created
    else
      render json: { errors: @survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @survey.update(survey_params)
      render json: @survey
    else
      render json: { errors: @survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @survey.destroy
    head :no_content
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(
      :title,
      :description,
      :distribution_mode,
      :status,
      :start_date,
      :end_date,
      :settings,
      :project_id,
      :scale_id
    )
  end
end