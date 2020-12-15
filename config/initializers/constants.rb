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
EXCLUDE_COLUMNS = ["id", "patient_id", "created_at", "updated_at"].map(&:freeze).freeze
BODY_PART = ["shoulder", "elbow", "forearm", "wrist", "hip", "knee", "ankle"].map(&:freeze).freeze
DIRECTION = ["right", "left"].map(&:freeze).freeze
PART_LIMIT = [
  90, 90,
  25, 25,
  -10, -10,
  90, 90,
  40, 40,
  30, 30,
  35, 35,
  45, 45,
  25, 25,
  55, 55,
  70, 70,
  -10, -10,
  45, 45,
  45, 45,
  45, 45,
  35, 35,
  10, 10,
  25, 25,
  60, 60,
  0, 0,
  0, 0,
  10, 10,
  20, 20,
  20, 20,
  90, 90,
  -10, -10,
  10, 10,
  0, 0,
  20, 20,
  10, 10,
  0, 0,
  15, 15,
  10, 10,
].map(&:freeze).freeze
