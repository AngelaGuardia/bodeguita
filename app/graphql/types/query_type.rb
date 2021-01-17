module Types
  class QueryType < Types::BaseObject
    field :revenue, Float, null: true, description: 'Returns revenue per photographer' do
      argument :user_id, ID, required: true
    end

    def revenue(user_id:)
      photographer = User.find(user_id.to_i)
      photographer
      .order_images
      .sum('order_images.price * order_images.quantity')
    end
  end
end
