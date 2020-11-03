class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :patient_id
      t.integer :age
      t.float :height
      t.float :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
