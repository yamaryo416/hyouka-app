class CreateTactileScales < ActiveRecord::Migration[6.0]
  def change
    create_table :tactile_scales do |t|
      t.integer :right_upper_arm
      t.integer :left_upper_arm
      t.integer :right_forearm
      t.integer :left_forearm
      t.integer :right_hand
      t.integer :left_hand
      t.integer :right_thigh
      t.integer :left_thigh
      t.integer :right_lower_leg
      t.integer :left_lower_leg
      t.integer :right_rearfoot
      t.integer :left_rearfoot
      t.integer :right_forefoot
      t.integer :left_forefoot
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
