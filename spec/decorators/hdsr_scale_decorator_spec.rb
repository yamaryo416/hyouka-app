require 'rails_helper'

RSpec.describe "HdsrScaleDecorator", type: :decorator do
  subject { hdsr.decorate }

  let!(:hdsr) do
    create(:hdsr_scale, age: 1,
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
                        five_goods: 5,
                        vegetables: 5)
  end

  it "show total score" do
    expect(subject.total_score).to eq 26
  end
end
