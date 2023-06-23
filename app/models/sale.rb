class Sale < ApplicationRecord
  belongs_to :stock

  def self.profit_or_loss_by_month(year)
    joins(:stock)
      .where('extract(year from sold_at) = ?', year)
      .group('extract(month from sold_at)')
      .select('extract(month from sold_at) as month, sum(quantity * stocks.price) as total')
  end
end
