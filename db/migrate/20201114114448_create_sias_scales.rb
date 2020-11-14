class CreateSiasScales < ActiveRecord::Migration[6.0]
  def change
    create_table :sias_scales do |t|
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
