require 'rails_helper'

RSpec.describe Mutations::Discounts::CreateDiscount, type: :request do
  describe '.resolve' do
    before :each do
      @anna = create(:user, :photographer, :with_images)
      images = @anna.images

      post graphql_path, params: { query: query(@anna.id) }
      result = JSON.parse(response.body, symbolize_names: true)

      @data = result[:data][:createDiscount]
    end

    it 'creates a discount' do
      expect(@data[:userId]).to eq(@anna.id.to_s)
      expect(@data[:name]).to eq("Summer Sale")
      expect(@data[:minimumQuantity]).to eq(5)
      expect(@data[:percentage]).to eq(0.5)
    end

    def query(id)
      <<~GQL
        mutation {
          createDiscount(input:{
              userId: #{id}
              name: "Summer Sale"
              minimumQuantity: 5
              percentage: 0.5
              }) {
                id
                userId
                name
                minimumQuantity
                percentage
              }
            }
      GQL
    end
  end
end
