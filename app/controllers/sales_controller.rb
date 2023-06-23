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
      redirect_to sales_path, notice: 'Sale created successfully.'
    else
      render :new
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:stock_id, :quantity, :sold_at, :price)
  end
end
