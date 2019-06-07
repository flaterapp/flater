class Rental < ApplicationRecord
  belongs_to :flat
  has_one :tenant, class_name: "User", foreign_key: "tenant_id"
  has_many :dossiers, dependent: :destroy
  has_many :tasks, dependent: :destroy

  def pending?
    pending == true
  end

  def status
    if self.pending
      { text: "pending", icon: "clock", color: "warning" }
    elsif self.start_date >= Date.today
      { text: "future rental", icon: "check", color: "info" }
    elsif self.end_date.nil? == false && self.end_date < Date.today
      { text: "previous rental", icon: "check", color: "secondary" }
    else
      { text: "current rental", icon: "check", color: "primary" }
    end
  end
end
