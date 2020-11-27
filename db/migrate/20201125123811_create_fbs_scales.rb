class CreateFbsScales < ActiveRecord::Migration[6.0]
  def change
    create_table :fbs_scales do |t|
      t.integer :stand_up
      t.integer :standing
      t.integer :sitting
      t.integer :sit_down
      t.integer :transfer
      t.integer :standing_with_eyes_close
      t.integer :standing_with_leg_close
      t.integer :reach_forward
      t.integer :pickup_from_floor
      t.integer :turn_around
      t.integer :one_rotation
      t.integer :stepup_and_down
      t.integer :tandem_standing
      t.integer :standing_with_one_leg
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
