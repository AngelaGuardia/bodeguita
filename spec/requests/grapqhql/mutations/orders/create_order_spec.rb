require 'rails_helper'

RSpec.describe Mutations::Orders::CreateOrder, type: :request do
  describe '.resolve' do
    before :each do
      photographer = create(:user, :photographer)
      @image1 = create(:image, user: photographer, price: 100.0)
      @image2 = create(:image, user: photographer, price: 10.0)
      @image3 = create(:image, user: photographer, price: 1.0)
      @buyer = create(:user, :buyer)

      @cart = { @image1.id => 1, @image2.id => 1, @image3.id => 1 }
    end

    it 'creates order' do
      post graphql_path, params: { query: query(@cart) }
      result = JSON.parse(response.body, symbolize_names: true)

      data = result[:data][:createOrder]

      expect(data[:userId]).to eq(@buyer.id.to_s)
      expect(data[:billingAddress]).to eq(@buyer.address)
      expect(data[:city]).to eq(@buyer.city)
      expect(data[:state]).to eq(@buyer.state)
      expect(data[:zip]).to eq(@buyer.zip)
      expect(data[:ccNumber]).to eq(123456789)
      expect(data[:ccName]).to eq("#{@buyer.first_name} #{@buyer.last_name}")
      expect(data[:status]).to eq("Approved")
    end

    it 'creates Order Images related to order' do
      post graphql_path, params: { query: query(@cart) }

      expect(OrderImage.all.size).to eq(3)
    end

    it 'updates image inventory' do
      initial_inventory_i1 = @image1.inventory
      initial_inventory_i2 = @image2.inventory
      initial_inventory_i3 = @image3.inventory

      post graphql_path, params: { query: query(@cart) }

      expect(@image1.reload.inventory).to eq(initial_inventory_i1 - 1)
      expect(@image2.reload.inventory).to eq(initial_inventory_i2 - 1)
      expect(@image3.reload.inventory).to eq(initial_inventory_i3 - 1)
    end

    def query(cart)
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
