class CreateMasScales < ActiveRecord::Migration[6.0]
  def change
    create_table :mas_scales do |t|
      t.integer :elbow_joint
      t.integer :wrist_joint
      t.integer :knee_joint
      t.integer :ankle_joint
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
