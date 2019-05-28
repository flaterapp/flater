class Flat < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  has_many :rentals, dependent: :destroy
end
