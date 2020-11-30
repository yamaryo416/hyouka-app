class CreateFactScales < ActiveRecord::Migration[6.0]
  def change
    create_table :fact_scales do |t|
      t.integer :sitting_with_upper_limb_support
      t.integer :sitting_with_no_support
      t.integer :lower_lateral_dynamic_sitting
      t.integer :forward_dynamic_sitting
      t.integer :lateral_dynamic_sitting
      t.integer :rear_lateral_dynamic_sitting
      t.integer :rear_dynamic_sitting
      t.integer :lateral_dynamic_sitting_with_trunk_rotation
      t.integer :trunk_rotation
      t.integer :trunk_extenxion
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
