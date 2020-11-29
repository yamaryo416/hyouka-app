class CreateBathyesthesiaScales < ActiveRecord::Migration[6.0]
  def change
    create_table :bathyesthesia_scales do |t|
      t.integer :right_upper_limb
      t.integer :left_upper_limb
      t.integer :right_lower_limb
      t.integer :left_lower_limb
      t.integer :right_finger
      t.integer :left_finger
      t.integer :right_toe
      t.integer :left_toe
      t.references :patient, null: false, foreign_key: true
      t.timestamps
    end
  end
end
