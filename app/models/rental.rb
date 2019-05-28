class Rental < ApplicationRecord
  belongs_to :flat
  has_one :user
end
