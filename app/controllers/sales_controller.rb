class SalesController < ApplicationController
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      # Update the stock quantity
      stock = @sale.stock
      stock.quantity -= @sale.quantity
      stock.save

      redirect_to sales_path, notice: 'Sale was successfully created.'
    else
      render :new
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:stock_id, :quantity, :sold_at, :price)
  end
end
