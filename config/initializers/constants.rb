THREE_WORD_SUBTRACTION_ATTRIBUTES = [
  :first_three_word,
  :second_three_word,
  :third_three_word,
  :first_subtraction,
  :second_subtraction,
  :revese_three_number,
  :revese_four_number,
].map(&:freeze).freeze
AGE_AND_TODAY_ATTRIBUTES = [
  :age,
  :year,
  :month,
  :day,
  :day_of_the_week
].map(&:freeze).freeze
EXCLUDE_COLUMNS = ["id", "patient_id", "created_at", "updated_at"].map(&:freeze).freeze
BODY_PART = ["shoulder", "elbow", "forearm", "wrist", "hip", "knee", "ankle"].map(&:freeze).freeze
DIRECTION = ["right", "left"].map(&:freeze).freeze
