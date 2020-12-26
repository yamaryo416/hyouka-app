require 'rails_helper'

RSpec.describe "ApplicationDecorator", type: :decorator do
  subject { patient.decorate }

  let!(:patient) { create(:patient, created_at: DateTime.new(2020, 12, 1)) }

  it "show date of creation" do
    expect(subject.date_of_creation).to eq "2020/12/01"
  end
end
