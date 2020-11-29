class CreateNrsScales < ActiveRecord::Migration[6.0]
  def change
    create_table :nrs_scales do |t|
      t.integer :rating
      t.integer :status
      t.string :supplement
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
