class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.text :billing_address
      t.string :city
      t.string :state
      t.string :zip
      t.bigint :cc_number
      t.string :cc_name
      t.string :status

      t.timestamps
    end
  end
end
