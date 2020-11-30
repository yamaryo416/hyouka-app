APA_ATTRIBUTES = [
  "from_sitting_to_standing",
  "standing_on_tiptoes",
  "standing_on_one_leg"
].map(&:freeze).freeze
CPA_ATTRIBUTES = [
  "forward_step",
  "back_step",
  "lateral_step"
].map(&:freeze).freeze
SENSORY_FUNCTION_ATTRIBUTES = [
  "standing",
  "standing_with_eyes_close",
  "standing_on_the_slope"
].map(&:freeze).freeze
DYNAMIC_WALKING_ATTRIBUTES = [
  "change_walking_speed",
  "walking_with_rotating_the_head",
  "pibot_turn",
  "straddling_obstacles",
  "tug"
].map(&:freeze).freeze
THREE_WORD_SUBTRACTION_ATTRIBUTES = [
  :first_three_word,
  :second_three_word,
  :third_three_word,
  :first_subtraction,
  :second_subtraction,
  :revese_three_number,
  :revese_four_number
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
