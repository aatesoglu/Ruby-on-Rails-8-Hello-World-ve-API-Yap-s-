class Analysis < ApplicationRecord
  # Enums - Rails 7+ syntax
  enum :analysis_type, { 
    descriptive: 0, 
    correlation: 1, 
    regression: 2, 
    factor_analysis: 3, 
    reliability: 4,
    chi_square: 5,
    survival: 6,
    roc: 7
  }
  enum :status, { pending: 0, running: 1, completed: 2, failed: 3 }
  
  # Associations
  belongs_to :project
  belongs_to :survey
  
  # Validations
  validates :analysis_type, presence: true
  validates :credit_cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  # Callbacks
  before_create :calculate_credit_cost
  
  # Methods
  def execute
    return false unless validate_data
    return false unless project.use_credits(credit_cost, "Analysis: #{analysis_type}")
    
    update!(status: :running, executed_at: Time.current)
    
    begin
      result = perform_analysis
      update!(status: :completed, results: result)
      true
    rescue => e
      update!(status: :failed, results: { error: e.message })
      Rails.logger.error("Analysis failed: #{e.message}")
      false
    end
  end
  
  def validate_data
    unless survey.responses.completed.any?
      errors.add(:base, "No completed responses available for analysis")
      return false
    end
    true
  end

  def completed?
    status == "completed"
  end

  def failed?
    status == "failed"
  end
  
  private
  
  def calculate_credit_cost
    costs = {
      descriptive: 5,
      correlation: 8,
      regression: 10,
      factor_analysis: 15,
      reliability: 10,
      chi_square: 8,
      survival: 12,
      roc: 10
    }
    self.credit_cost = costs[analysis_type.to_sym] || 5
  end
  
  def perform_analysis
    # Placeholder - gerçek R/statistical analysis burada
    case analysis_type
    when "descriptive"
      perform_descriptive_analysis
    when "correlation"
      perform_correlation_analysis
    when "regression"
      perform_regression_analysis
    else
      { status: 'completed', timestamp: Time.current, message: "Analysis type: #{analysis_type}" }
    end
  end

  def perform_descriptive_analysis
    {
      mean: 0,
      median: 0,
      std_dev: 0,
      min: 0,
      max: 0,
      count: survey.responses.completed.count,
      timestamp: Time.current
    }
  end

  def perform_correlation_analysis
    {
      correlation_coefficient: 0,
      p_value: 0,
      timestamp: Time.current
    }
  end

  def perform_regression_analysis
    {
      r_squared: 0,
      coefficients: [],
      timestamp: Time.current
    }
  end
end