class Patient < ApplicationRecord
  belongs_to :therapist
  default_scope -> { order(created_at: :desc) }
  validates :unique_id, presence: true, length: {is: 8}, uniqueness: true
  enum sex: { undefined: 0, man: 1, woman: 2 }
end
