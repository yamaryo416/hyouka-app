class Patient < ApplicationRecord
  belongs_to :therapist
  has_one :sias_scale, dependent: :destroy
  has_one :rom_scale, dependent: :destroy
  has_one :mmt_scale, dependent: :destroy
  has_one :fbs_scale, dependent: :destroy
  validates :unique_id, presence: true, length: { is: 8 }, uniqueness: true
  enum sex: { undefined: 0, man: 1, woman: 2 }
end
