class CreateOrderImages < ActiveRecord::Migration[6.1]
  def change
    create_table :order_images do |t|
      t.references :order, null: false, foreign_key: true
      t.references :image, null: false, foreign_key: true
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
