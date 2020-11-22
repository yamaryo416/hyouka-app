class CreateSiasScales < ActiveRecord::Migration[6.0]
  def change
    create_table :sias_scales do |t|
      t.integer :shoulder_motor_function
      t.float :finger_motor_function
      t.integer :hip_motor_function
      t.integer :knee_motor_function
      t.integer :foot_motor_function
      t.float :upper_limb_muscle_tone
      t.float :lower_limb_muscle_tone
      t.float :upper_limb_tendon_reflex
      t.float :lower_limb_tendon_reflex
      t.integer :upper_limb_tactile
      t.integer :lower_limb_tactile
      t.integer :upper_limb_sense_of_position
      t.integer :lower_limb_sense_of_position
      t.integer :shoulder_joint_rom
      t.integer :knee_joint_rom
      t.integer :pain
      t.integer :trunk_verticality
      t.integer :abdominal_mmt
      t.integer :visuospatial_cognition
      t.float :speech
      t.integer :gripstrength
      t.integer :quadriceps_mmt
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
