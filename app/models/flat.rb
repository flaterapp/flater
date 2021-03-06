class Flat < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  has_many :rentals, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def num_candidates
    self.rentals.where(pending: true).first.dossiers.count
  end

  def has_visits?
    self.rentals.where(pending: true).first.tasks.exists?(action: "Visit")
  end

  def pending_rental?
    self.rentals.exists?(pending: true)
  end

  def pending_rental
     self.rentals.where(pending: true)
  end

  def pending_rental_id
    self.rentals.where(pending: true).first.id
  end

  def initial_rent
    return nil unless rentals.any?
    return rentals.find_by(pending: true).initial_rent if pending_rental?

    rentals.order(start_date: :desc).first.initial_rent
  end
end
