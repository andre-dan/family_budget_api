module Api
  module V1
    class DashboardController < ApplicationController
      def summary
        month = params[:month].presence&.to_i || Date.current.month
        year = params[:year].presence&.to_i || Date.current.year
        target_date = Date.new(year, month, 1)

        transactions = Transaction.for_month(target_date)

        # Calculamos apenas os lançamentos já pagos (efetivados no caixa)
        total_income = transactions.incomes.paid.sum(:amount)
        total_expense = transactions.expenses.paid.sum(:amount)
        balance = total_income - total_expense

        # Total de fiados a receber no mês (pendentes)
        total_pending_income = transactions.incomes.pending.sum(:amount)

        # Agrupamento por categoria (apenas despesas pagas)
        expenses_by_cat = transactions.expenses.paid
                                     .joins(:category)
                                     .group("categories.id", "categories.name", "categories.color")
                                     .sum(:amount)

        expenses_formatted = expenses_by_cat.map do |(cat_id, name, color), total|
          percentage = total_expense.positive? ? ((total / total_expense) * 100).round(2) : 0
          {
            category_id: cat_id,
            category_name: name,
            color: color,
            total: total.to_f,
            percentage: percentage
          }
        end

        render json: {
          summary: {
            total_income: total_income.to_f,
            total_expense: total_expense.to_f,
            balance: balance.to_f,
            total_pending_income: total_pending_income.to_f # Adicionado KPI de Fiados
          },
          expenses_by_category: expenses_formatted
        }
      end
    end
  end
end
