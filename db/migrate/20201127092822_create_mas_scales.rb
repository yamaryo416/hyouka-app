class CreateMasScales < ActiveRecord::Migration[6.0]
  def change
    create_table :mas_scales do |t|
      t.integer :right_elbow_joint
      t.integer :left_elbow_joint
      t.integer :right_wrist_joint
      t.integer :left_wrist_joint
      t.integer :right_knee_joint
      t.integer :left_knee_joint
      t.integer :right_ankle_joint
      t.integer :left_ankle_joint
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
