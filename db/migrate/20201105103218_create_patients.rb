class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :unique_id, null: false, default: ""
      t.integer :age, default: 0
      t.integer :sex
      t.float :weight
      t.float :height
      t.references :therapist, null: false, foreign_key: true

      t.timestamps
    end
    add_index :patients, :unique_id, unique: true
    add_index :patients, [:therapist_id, :created_at]
  end
end