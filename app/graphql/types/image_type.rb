module Types
  class ImageType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :price, Float, null: true
    field :url, String, null: true
    field :inventory, Integer, null: true
  end
end
