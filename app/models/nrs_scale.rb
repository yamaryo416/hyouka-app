class NrsScale < ApplicationRecord
  include Scope

  belongs_to :patient
  validates :rating, presence: true, inclusion: 0..10
  enum status: {
    undefined: nil,
    resting: 0,
    moving: 1,
    loading: 2,
  }
end
