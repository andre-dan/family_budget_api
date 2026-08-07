module Api
  module V1
    class TransactionsController < ApplicationController
      def index
        reference_date = parse_date(params[:month], params[:year])
        @transactions = Transaction.for_month(reference_date)
                                   .includes(:category)
                                   .order(date: :desc, created_at: :desc)

        render json: @transactions.as_json(include: { category: { only: [ :id, :name, :color ] } })
      end

      def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
          render json: @transaction.as_json(include: { category: { only: [ :id, :name, :color ] } }), status: :created
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Transação não encontrada" }, status: :not_found
      end

      private

      def transaction_params
        params.require(:transaction).permit(
          :description,
          :amount,
          :date,
          :kind,
          :category_id,
          :status,
          :payment_method,
          :customer_name,
          :due_date
        )
      end

      def parse_date(month, year)
        return Date.current if month.blank? || year.blank?
        Date.new(year.to_i, month.to_i, 1)
      rescue ArgumentError
        Date.current
      end
    end
  end
end
