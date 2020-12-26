class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.integer :age, default: nil
      t.integer :sex
      t.float :height
      t.float :weight
      t.references :therapist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
