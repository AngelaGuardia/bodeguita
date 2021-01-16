require 'rails_helper'

RSpec.describe OrderImage, type: :model do
  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :image }
  end

  describe 'Validations' do
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end
end
