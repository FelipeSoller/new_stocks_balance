class StocksController < ApplicationController
  def index
    @stocks = Stock.where('quantity > 0')
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      redirect_to stocks_path, notice: 'Stock created successfully.'
    else
      render :new
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:ticker, :quantity, :price)
  end
end
