class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :email
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
