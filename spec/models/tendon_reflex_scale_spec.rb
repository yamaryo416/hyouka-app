require 'rails_helper'

RSpec.describe TendonReflexScale, type: :model do
  it "is valid with patientid" do
    tendon_reflex_scale = build(:tendon_reflex_scale)
    expect(tendon_reflex_scale).to be_valid
  end

  it "is valid with all columns" do
    tendon_reflex_scale = build(:tendon_reflex_scale, jaw: 1,
                                                      abdominal: 1,
                                                      right_pectoral: 1,
                                                      left_pectoral: 1,
                                                      right_biceps: 1,
                                                      left_biceps: 1,
                                                      right_triceps: 1,
                                                      left_triceps: 1,
                                                      right_brachioradialis: 1,
                                                      left_brachioradialis: 1,
                                                      right_pronator: 1,
                                                      left_pronator: 1,
                                                      right_patellar_tendon: 1,
                                                      left_patellar_tendon: 1,
                                                      right_achilles_tendon: 1,
                                                      left_achilles_tendon: 1)
    expect(tendon_reflex_scale).to be_valid
  end

  it "is invalid without patientid" do
    tendon_reflex_scale = build(:tendon_reflex_scale, patient_id: nil)
    tendon_reflex_scale.valid?
    expect(tendon_reflex_scale.errors[:patient]).to include("を入力してください")
  end
end
