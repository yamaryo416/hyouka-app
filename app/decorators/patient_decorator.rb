# frozen_string_literal: true

module PatientDecorator
  def full_name
    "#{first_name} #{last_name}"
  end
end
