# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationRecordDecorator do
  let(:application_record) { ApplicationRecord.new.extend ApplicationRecordDecorator }
  subject { application_record }
  it { should be_a ApplicationRecord }
end
