module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :billing_address, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, Integer, null: true
    field :cc_number, Integer, null: true
    field :cc_name, String, null: true
    field :status, String, null: true
  end
end
