require 'rails_helper'

RSpec.describe HdsrScale, type: :model do
  it "is valid with patientid" do
    hdsr_scale = build(:hdsr_scale)
    expect(hdsr_scale).to be_valid
  end

  it "is valid with all columns" do
    hdsr_scale = build(:hdsr_scale, age: 1,
                                    year: 1,
                                    month: 1,
                                    day: 1,
                                    day_of_the_week: 1,
                                    place: 1,
                                    first_three_word: 1,
                                    second_three_word: 1,
                                    third_three_word: 1,
                                    first_subtraction: 1,
                                    second_subtraction: 1,
                                    revese_three_number: 1,
                                    revese_four_number: 1,
                                    memory_first_word: 1,
                                    memory_second_word: 1,
                                    memory_third_word: 1,
                                    five_goods: 1,
                                    vegetables: 1)
    expect(hdsr_scale).to be_valid
  end

  it "is invalid without patientid" do
    hdsr_scale = build(:hdsr_scale, patient_id: nil)
    hdsr_scale.valid?
    expect(hdsr_scale.errors[:patient]).to include("を入力してください")
  end
end
