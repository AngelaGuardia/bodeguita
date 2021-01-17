require 'rails_helper'

RSpec.describe Mutations::Discounts::CreateDiscount, type: :request do
  describe '.resolve' do
    before :each do
      @anna = create(:user, :photographer, :with_images)

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

    it 'Applies the discount when minimumQuantity is met' do
      image1 = create(:image, user: @anna, price: 100.0)
      @buyer = create(:user, :buyer)

      @cart = { image1.id => 5 }
      full_price = image1.price * 5

      post graphql_path, params: { query: order(@cart) }

      expect(Order.last.grand_total).not_to eq(full_price)
      expect(Order.last.grand_total).to eq(full_price * 0.5)
    end

    it 'Does not apply the discount when minimumQuantity is not met' do
      image1 = create(:image, user: @anna, price: 100.0)
      @buyer = create(:user, :buyer)

      @cart = { image1.id => 4 }
      full_price = image1.price * 4

      post graphql_path, params: { query: order(@cart) }

      expect(Order.last.grand_total).to eq(full_price)
      expect(Order.last.grand_total).not_to eq(full_price * 0.5)
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

    def order(cart)
      <<~GQL
        mutation {
          createOrder(input:{
              userId: "#{@buyer.id}"
              billingAddress: "#{@buyer.address}"
              city: "#{@buyer.city}"
              state: "#{@buyer.state}"
              zip: #{@buyer.zip}
              ccNumber: 123456789
              ccName: "#{@buyer.first_name} #{@buyer.last_name}"
              status: "Approved"
              cart: "#{cart}"
              }) {
                id
                userId
                billingAddress
                city
                state
                zip
                ccNumber
                ccName
                status
              }
            }
      GQL
    end
  end
end
