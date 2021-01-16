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
end
