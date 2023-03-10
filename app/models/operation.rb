class Operation < ApplicationRecord
  belongs_to :category
  belongs_to :otype
  validates :amount, :odate, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :odate, format: { with: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/ }
  validates :otype_id, :category_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }
  validates :description, length: {maximum: 255}
  scope :between_dates, ->(start_date, end_date) { where(odate: start_date..end_date) unless start_date.blank? || end_date.blank? }
  scope :category_is, ->(category_id) { where(category_id: category_id) unless category_id.blank?}
  scope :type_is, ->(otype_id) { where(otype_id: otype_id) unless otype_id.blank?}
  
  scope :last_month, -> {where(odate: Date.today.prev_month.beginning_of_month..Date.today.prev_month.end_of_month)}
  scope :this_month, -> {where(odate: Date.today.beginning_of_month..Date.today.end_of_month)}
  scope :top_x, ->(top_count) { order(amount: :desc).limit(top_count) }
  scope :group_by_period, ->(period) { period == "month" ? group("DATE_TRUNC('month', odate)") : group("DATE_TRUNC('week', odate)")}
  scope :last_x_periods, ->(x, period) {
     period == "month" ?
     where(odate: Date.today.months_ago(x).beginning_of_month..Date.today) : 
     where(odate: Date.today.weeks_ago(x).beginning_of_week..Date.today)
    }
  paginates_per 10

end
