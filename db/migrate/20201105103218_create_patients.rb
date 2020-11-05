class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :unique_id
      t.integer :age
      t.integer :sex
      t.float :weight
      t.float :height
      t.references :therapist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
