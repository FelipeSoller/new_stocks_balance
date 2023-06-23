class StocksController < ApplicationController
  def index
    @stocks = Item.all
  end

  def new
    @stock = Item.new
  end

  def create
    @stock = Item.new(stock_params)
    if @stock.save
      redirect_to stocks_path, notice: 'Item created successfully.'
    else
      render :new
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:name, :quantity, :price)
  end
end
