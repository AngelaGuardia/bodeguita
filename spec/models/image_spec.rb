require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_images }
    it { should have_many(:orders).through(:order_images) }
    it { should have_many(:discounts).through(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :url }
    it { should validate_presence_of :inventory }
  end

  describe 'Instance methods' do
    it '.discounted_price' do
      user = create(:user, :photographer, :with_images)
      create(:discount, user: user, minimum_quantity: 2, percentage: 0.5)
      image = user.images.first

      expect(image.discounted_price(1)).to eq(image.price)
      expect(image.discounted_price(5)).to eq(image.price * 0.5)
    end
  end
end
