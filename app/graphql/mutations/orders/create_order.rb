class Mutations::Orders::CreateOrder < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :billing_address, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, Integer, required: false
  argument :cc_number, Integer, required: false
  argument :cc_name, String, required: false
  argument :status, String, required: false
  argument :cart, GraphQL::Types::JSON, required: false

  type Types::OrderType

  def resolve(attributes)
    cart = eval(attributes.delete(:cart))
    order = Order.create(attributes)
    cart.each do |image_id, quantity|
      image = Image.find(image_id)
      OrderImage.create(order: order, image: image, price: image.price, quantity: quantity)
      image.update(inventory: image.inventory - quantity)
    end
    order
  end
end
