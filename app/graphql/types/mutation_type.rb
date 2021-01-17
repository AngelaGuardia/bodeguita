module Types
  class MutationType < Types::BaseObject
    field :update_image, mutation: Mutations::Images::UpdateImage
    field :create_order, mutation: Mutations::Orders::CreateOrder
    field :create_discount, mutation: Mutations::Discounts::CreateDiscount
  end
end
