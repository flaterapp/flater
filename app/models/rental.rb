class Rental < ApplicationRecord
  belongs_to :flat
  has_one :tenant, class_name: "User", foreign_key: "tenant_id"
  has_many :dossiers, dependent: :destroy
  has_many :tasks, dependent: :destroy

  def pending?
    pending == true
  end

  # def initial_rent
  #   initial_rent.round(2)
  # end
end
