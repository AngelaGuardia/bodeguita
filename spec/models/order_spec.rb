require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_images }
    it { should have_many(:images).through(:order_images) }
  end

  describe 'Validations' do
    it { should validate_presence_of :billing_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :cc_number }
    it { should validate_presence_of :cc_name }
    it { should validate_presence_of :status }
  end

  describe 'Instance methods' do
    before :each do
      photographer = create(:user, :photographer)
      @image1 = create(:image, user: photographer, price: 100.0)
      @image2 = create(:image, user: photographer, price: 10.0)
      @image3 = create(:image, user: photographer, price: 1.0)
      @buyer = create(:user, :buyer)

      @order = create(:order)
    end

    it 'knows when an order is fulfillable' do
      cart = { @image1.id => 1, @image2.id => 1, @image3.id => 1 }

      expect(@order.fulfillable?(cart)).to be_truthy
    end

    it 'knows when an order is not fulfillable' do
      cart = { @image1.id => @image1.inventory + 1 }

      expect(@order.fulfillable?(cart)).to be(false)
    end

    it 'can fulfill itself' do
      cart = { @image1.id => 1 }

      @order.fulfill(cart)

      expect(OrderImage.all.size).to eq(1)
      expect(OrderImage.first.image_id).to eq(@image1.id)
      expect(OrderImage.first.quantity).to eq(1)
      expect(OrderImage.first.price).to eq(@image1.price)
    end

    it 'calculates the grand_total' do
      cart = { @image1.id => 1, @image2.id => 1, @image3.id => 1 }
      @order.fulfill(cart)
      price = cart.sum { |id, qty| Image.find(id).price * qty }
      expect(@order.grand_total).to eq(price)
    end
  end
end
