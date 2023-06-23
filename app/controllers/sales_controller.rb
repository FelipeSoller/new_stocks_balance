class SalesController < ApplicationController
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
    @stock = Stock.find(params[:stock_id])
    @stocks = Stock.where('quantity > 0')
  end

  def create
    @sale = Sale.new(sale_params)

    @sale.sold_at ||= Date.current

    if @sale.quantity > @sale.stock.quantity
      redirect_to new_sale_path, alert: 'Insufficient stock for the sale.'
      return
    end

    if @sale.save
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
