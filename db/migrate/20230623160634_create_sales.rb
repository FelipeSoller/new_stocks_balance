class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :stock, null: false, foreign_key: true
      t.integer :quantity
      t.date :sold_at

      t.timestamps
    end
  end
end
