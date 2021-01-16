require 'rails_helper'

RSpec.describe Mutations::Images::UpdateImage, type: :request do
  describe '.resolve' do
    it 'updates image attributes' do
      user = create(:user, :photographer)
      image = create(:image, user: user)

      post graphql_path, params: { query: query(image.id) }
      result = JSON.parse(response.body, symbolize_names: true)

      data = result[:data][:updateImage]

      new_name = "new image name"
      new_description = "new desc"
      new_price = 121.50
      new_url = "prettypic.com"
      new_inventory = 999

      expect(data[:userId]).to eq(user.id.to_s)
      expect(data[:name]).to eq(new_name)
      expect(data[:description]).to eq(new_description)
      expect(data[:price]).to eq(new_price)
      expect(data[:url]).to eq(new_url)
      expect(data[:inventory]).to eq(new_inventory)
    end

    def query(image_id)
      <<~GQL
        mutation {
          updateImage(input:{
              id: "#{image_id}"
              name: "new image name"
              description: "new desc"
              price: 121.50
              url: "prettypic.com"
              inventory: 999
              }) {
                id
                userId
                name
                description
                price
                url
                inventory
              }
            }
      GQL
    end
  end
end
