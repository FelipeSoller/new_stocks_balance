class Sale < ApplicationRecord
  belongs_to :stock

  def self.profit_or_loss_by_month(year)
    joins(:stock)
      .where('extract(year from sales.sold_at) = ?', year)
      .group('extract(month from sales.sold_at), sales.quantity, stocks.price')
      .select('extract(month from sales.sold_at) as month, sum(sales.profit_or_loss) as total, ROUND((sum(sales.profit_or_loss) / (sales.quantity * stocks.price) * 100), 2) as percentage')
  end
end
