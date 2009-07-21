class ReturnMutter < ActiveRecord::Base
  has_many :mutters
  belongs_to :user
end
