require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'query revenue' do
    it 'can get all revenue from a photographer' do
      photographer1 = create(:photographer, :with_images)
      order1 = create(:order)
      revenue = 0
      photographer1.images.each do |image|
        create(:order_image, order: order1, image: image, quantity: 2, price: image.price)
        revenue += image.price * 2
      end

      photographer2 = create(:photographer, :with_images)
      order2 = create(:order)
      photographer2.images.each do |image|
        create(:order_image, order: order2, image: image, quantity: 2, price: image.price)
      end

      post graphql_path, params: { query: query(photographer1.id) }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:revenue].round(2)).to eq(revenue.round(2))
    end

    def query(id)
      <<~GQL
        query {
          revenue(userId: #{id})
            }
      GQL
    end
  end
end
