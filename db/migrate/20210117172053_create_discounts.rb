class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.float :percentage
      t.integer :minimum_quantity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
