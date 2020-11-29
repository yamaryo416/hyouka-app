class CreateHdsrScales < ActiveRecord::Migration[6.0]
  def change
    create_table :hdsr_scales do |t|
      t.integer :age
      t.integer :year
      t.integer :month
      t.integer :day
      t.integer :day_of_the_week
      t.integer :place
      t.integer :first_three_word
      t.integer :second_three_word
      t.integer :third_three_word
      t.integer :first_subtraction
      t.integer :second_subtraction
      t.integer :revese_three_number
      t.integer :revese_four_number
      t.integer :memory_first_word
      t.integer :memory_second_word
      t.integer :memory_third_word
      t.integer :five_goods
      t.integer :vegetables
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
