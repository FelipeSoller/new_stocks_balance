class AddProfitOrLossToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :profit_or_loss, :decimal
  end
end
