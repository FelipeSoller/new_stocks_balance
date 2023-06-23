class ReportsController < ApplicationController
  def monthly_profit_or_loss
    @year = params[:year] || Time.current.year
    @profit_or_loss_by_month = Sale.profit_or_loss_by_month(@year)
  end
end
