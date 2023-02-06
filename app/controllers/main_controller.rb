class MainController < ApplicationController
  def index
    @top3ops = Operation.select(:description, :amount, :odate).last_month.top_x(3).type_is(2)
    @profit_last_month = Operation.last_month.type_is(1).sum(:amount)
    @expenses_last_month = Operation.last_month.type_is(2).sum(:amount)
    @most_expensive_category = Operation.joins(:category).last_month.type_is(2).group(:name).sum(:amount).max_by{ |k,v| v }
    
  end
end
