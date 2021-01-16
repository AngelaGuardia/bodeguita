require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :url }
    it { should validate_presence_of :inventory }
  end
end
