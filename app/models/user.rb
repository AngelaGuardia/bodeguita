class User < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :email

  validates_uniqueness_of :email

  enum role: ['buyer', 'photographer']
end
