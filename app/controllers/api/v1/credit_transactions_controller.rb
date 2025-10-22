class Api::V1::CreditTransactionsController < ApplicationController
  before_action :set_credit_transaction, only: %i[show update destroy]

  def index
    @credit_transactions = CreditTransaction.all
    render json: @credit_transactions
  end

  def show
    render json: @credit_transaction
  end

  def create
    @credit_transaction = CreditTransaction.new(credit_transaction_params)
    if @credit_transaction.save
      render json: @credit_transaction, status: :created
    else
      render json: { errors: @credit_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @credit_transaction.update(credit_transaction_params)
      render json: @credit_transaction
    else
      render json: { errors: @credit_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @credit_transaction.destroy
    head :no_content
  end

  private

  def set_credit_transaction
    @credit_transaction = CreditTransaction.find(params[:id])
  end

  def credit_transaction_params
    params.require(:credit_transaction).permit(
      :transaction_type,
      :amount,
      :balance_after,
      :description,
      :user_id,
      :project_id
    )
  end
end