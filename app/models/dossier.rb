class Dossier < ApplicationRecord
  belongs_to :rental
  belongs_to :candidate, class_name: "User", foreign_key: "candidate_id"
end
