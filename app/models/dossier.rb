class Dossier < ApplicationRecord
  belongs_to :rental
  belongs_to :user
end
