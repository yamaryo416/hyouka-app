class ApplicationRecord < ActiveRecord::Base
  EXCLUDE_COLUMNS = ["id", "patient_id", "created_at", "updated_at"].map(&:freeze).freeze
  self.abstract_class = true
end
