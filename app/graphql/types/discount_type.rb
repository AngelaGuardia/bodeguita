module Types
  class DiscountType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: true
    field :name, String, null: true
    field :percentage, Float, null: true
    field :minimum_quantity, Integer, null: true
  end
end
