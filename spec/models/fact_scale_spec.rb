require 'rails_helper'

RSpec.describe FactScale, type: :model do
  it "is valid with patientid" do
    fact_scale = build(:fact_scale)
    expect(fact_scale).to be_valid
  end

  it "is valid with all columns" do
    fact_scale = build(:fact_scale, sitting_with_upper_limb_support: 1,
                                    sitting_with_no_support: 1,
                                    lower_lateral_dynamic_sitting: 1,
                                    forward_dynamic_sitting: 2,
                                    lateral_dynamic_sitting: 2,
                                    rear_lateral_dynamic_sitting: 1,
                                    rear_dynamic_sitting: 2,
                                    lateral_dynamic_sitting_with_trunk_rotation: 3,
                                    trunk_rotation: 3,
                                    trunk_extenxion: 3)
    expect(fact_scale).to be_valid
  end

  it "is invalid without patientid" do
    fact_scale = build(:fact_scale, patient_id: nil)
    fact_scale.valid?
    expect(fact_scale.errors[:patient]).to include("を入力してください")
  end
end
