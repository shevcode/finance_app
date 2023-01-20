class Operation < ApplicationRecord
  belongs_to :category
  enum otype: [ :Дохід, :Витрата ]
  validates :amount, :odate, :otype, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
