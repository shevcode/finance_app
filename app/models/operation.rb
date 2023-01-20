class Operation < ApplicationRecord
  belongs_to :category
  enum otype: [ :дохід, :витрата ]
  validates :amount, :odate, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
