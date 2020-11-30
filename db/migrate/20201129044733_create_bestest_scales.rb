class CreateBestestScales < ActiveRecord::Migration[6.0]
  def change
    create_table :bestest_scales do |t|
      t.integer :from_sitting_to_standing
      t.integer :standing_on_tiptoes
      t.integer :standing_on_one_leg
      t.integer :forward_step
      t.integer :back_step
      t.integer :lateral_step
      t.integer :standing
      t.integer :standing_with_eyes_close
      t.integer :standing_on_the_slope
      t.integer :change_walking_speed
      t.integer :walking_with_rotating_the_head
      t.integer :pibot_turn
      t.integer :straddling_obstacles
      t.integer :tug  
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
