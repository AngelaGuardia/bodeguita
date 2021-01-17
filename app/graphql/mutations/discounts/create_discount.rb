class Mutations::Discounts::CreateDiscount < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :name, String, required: true
  argument :percentage, Float, required: true
  argument :minimum_quantity, Integer, required: true

  type Types::DiscountType

  def resolve(attributes)
    Discount.create(attributes)
  end
end
