module Types
  class OrderImageType < Types::BaseObject
    field :id, ID, null: false
    field :order_id, ID, null: false
    field :image_id, ID, null: false
    field :price, Float, null: true
    field :quantity, Integer, null: true
  end
end
