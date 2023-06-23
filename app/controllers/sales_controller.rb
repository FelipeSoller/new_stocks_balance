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

    if insufficient_stock?
      redirect_to new_sale_path, alert: 'Insufficient stock for the sale.'
    elsif save_sale_and_update_stock
      redirect_to sales_path, notice: 'Sale was successfully created.'
    else
      render :new
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:stock_id, :quantity, :sold_at, :price)
  end

  def insufficient_stock?
    @sale.quantity > @sale.stock.quantity
  end

  def save_sale_and_update_stock
    @sale.profit_or_loss = (@sale.quantity * (@sale.price - @sale.stock.price)).to_f

    if @sale.save
      update_stock_quantity
      true
    else
      false
    end
  end

  def update_stock_quantity
    @sale.stock.quantity -= @sale.quantity
    @sale.stock.save
  end
end
