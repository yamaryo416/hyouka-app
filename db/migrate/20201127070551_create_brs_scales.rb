class CreateBrsScales < ActiveRecord::Migration[6.0]
  def change
    create_table :brs_scales do |t|
      t.integer :upper_limb
      t.integer :finger
      t.integer :lower_limb
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
