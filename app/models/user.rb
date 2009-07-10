class User < ActiveRecord::Base
  has_many   :mutters
end
