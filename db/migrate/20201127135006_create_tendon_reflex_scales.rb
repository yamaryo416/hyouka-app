class CreateTendonReflexScales < ActiveRecord::Migration[6.0]
  def change
    create_table :tendon_reflex_scales do |t|
      t.integer :jaw
      t.integer :abdominal
      t.integer :right_pectoral
      t.integer :left_pectoral
      t.integer :right_biceps
      t.integer :left_biceps
      t.integer :right_triceps
      t.integer :left_triceps
      t.integer :right_brachioradialis
      t.integer :left_brachioradialis
      t.integer :right_pronator
      t.integer :left_pronator
      t.integer :right_patellar_tendon
      t.integer :left_patellar_tendon
      t.integer :right_achilles_tendon
      t.integer :left_achilles_tendon
      t.references :patient, null:false, foreign_key: true

      t.timestamps
    end
  end
end
