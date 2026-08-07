class Transaction < ApplicationRecord
  belongs_to :category

  # Rails 7.1+ syntax para os enums
  enum :kind, { expense: 'expense', income: 'income' }
  enum :status, { paid: 'paid', pending: 'pending' }, default: 'paid'
  enum :payment_method, { 
    pix: 'pix', 
    credit_card: 'credit_card', 
    debit_card: 'debit_card', 
    cash: 'cash', 
    promissory_note: 'promissory_note' 
  }, default: 'pix'

  validates :description, :amount, :date, :kind, :status, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # Scopes úteis
  scope :for_month, ->(date) { where(date: date.beginning_of_month..date.end_of_month) }
  scope :incomes, -> { where(kind: 'income') }
  scope :expenses, -> { where(kind: 'expense') }
  scope :pending_receivables, -> { income.pending } # Fiados a receber
end