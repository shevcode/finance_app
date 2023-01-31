class Operation < ApplicationRecord
  belongs_to :category
  belongs_to :otype
  validates :amount, :odate, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :odate, format: { with: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/ }
  validates :otype_id, :category_id, format: { with: /\d{1,3}/ }
  validates :description, length: {maximum: 255}
  paginates_per 10
end
