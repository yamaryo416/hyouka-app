class HdsrScale < ApplicationRecord
  include ScaleModule
  belongs_to :patient
  with_options inclusion: 0..1, allow_nil: true do
    validates :age
    validates :year
    validates :month
    validates :day
    validates :day_of_the_week
    validates :first_three_word
    validates :second_three_word
    validates :third_three_word
    validates :first_subtraction
    validates :second_subtraction
    validates :revese_three_number
    validates :revese_four_number
  end
  with_options inclusion: 0..2, allow_nil: true do
    validates :place
    validates :memory_first_word
    validates :memory_second_word
    validates :memory_third_word
  end
  with_options inclusion: 0..5, allow_nil: true do
    validates :five_goods
    validates :vegetables
  end

  def total_score
    total_score = 0
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name) || value.nil?
        next
      else
        total_score += value
      end
    end
    total_score
  end
end
