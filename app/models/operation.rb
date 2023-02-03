class Operation < ApplicationRecord
  belongs_to :category
  belongs_to :otype
  validates :amount, :odate, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :odate, format: { with: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/ }
  validates :otype_id, :category_id, format: { with: /\d{1,3}/ }
  validates :description, length: {maximum: 255}
  scope :between_dates, ->(start_date, end_date) { where(odate: start_date..end_date) }
  scope :category_is, ->(category_id) { where(category_id: category_id) unless category_id.blank?}
  scope :type_is, ->(otype_id) { where(otype_id: otype_id) }
  paginates_per 10
end
