class PurchasesController < ApplicationController
  def new
    @purchase = Purchase.new
    @stock = Stock.find(params[:stock_id])
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @stock = Stock.find(params[:purchase][:stock_id])

    if @purchase.save
      update_stock
      redirect_to stocks_path, notice: 'Purchase was successfully created.'
    else
      render :new
    end
  end

  private

  def update_stock
    previous_total_price = @stock.quantity * @stock.price

    @stock.quantity += @purchase.quantity
    new_total_price = previous_total_price + @purchase.quantity * @purchase.price
    @stock.price = new_total_price / @stock.quantity

    @stock.save
  end

  def purchase_params
    params.require(:purchase).permit(:stock_id, :quantity, :price)
  end
end
