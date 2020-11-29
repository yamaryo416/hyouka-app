class Patient < ApplicationRecord
  belongs_to :therapist
  has_one :sias_scale, dependent: :destroy
  has_one :rom_scale, dependent: :destroy
  has_one :mmt_scale, dependent: :destroy
  has_one :fbs_scale, dependent: :destroy
  has_one :brs_scale, dependent: :destroy
  has_one :mas_scale, dependent: :destroy
  has_one :tendon_reflex_scale, dependent: :destroy
  has_one :tactile_scale, dependent: :destroy
  has_one :bathyesthesia_scale, dependent: :destroy
  has_many :nrs_scales, dependent: :destroy
  validates :unique_id, presence: true, length: { is: 8 }, uniqueness: true
  enum sex: { undefined: 0, man: 1, woman: 2 }
end
