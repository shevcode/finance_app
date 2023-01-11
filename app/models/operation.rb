class Operation < ApplicationRecord
  belongs_to :category
  validates :amount, :odate, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
