EXCLUDE_COLUMNS = ["id", "patient_id", "created_at", "updated_at"].map(&:freeze).freeze
BODY_PART = ["shoulder", "elbow", "forearm", "wrist", "hip", "knee", "ankle"].map(&:freeze).freeze
DIRECTION = ["right", "left"].map(&:freeze).freeze
