module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :address, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, Integer, null: true
    field :email, String, null: true
    field :role, Integer, null: true
  end
end
