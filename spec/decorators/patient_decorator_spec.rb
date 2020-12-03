# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PatientDecorator do
  let(:patient) { Patient.new.extend PatientDecorator }
  subject { patient }
  it { should be_a Patient }
end
