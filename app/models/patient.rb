class Patient < ApplicationRecord
  include Scope
  belongs_to :therapist
  has_many :sias_scales, dependent: :destroy
  has_many :rom_scales, dependent: :destroy
  has_many :mmt_scales, dependent: :destroy
  has_many :fbs_scales, dependent: :destroy
  has_many :brs_scales, dependent: :destroy
  has_many :mas_scales, dependent: :destroy
  has_many :tendon_reflex_scales, dependent: :destroy
  has_many :tactile_scales, dependent: :destroy
  has_one :bathyesthesia_scale, dependent: :destroy
  has_many :nrs_scales, dependent: :destroy
  has_many :hdsr_scales, dependent: :destroy
  has_many :bestest_scales, dependent: :destroy
  has_many :fact_scales, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 10 }
  validates :last_name, presence: true, length: { maximum: 10 }

  enum sex: { undefined: 0, man: 1, woman: 2 }
end
