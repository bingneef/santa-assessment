class CreateElves < ActiveRecord::Migration[5.2]
  def change
    create_table :elves do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.string :speciality, null: false

      t.timestamps
    end
  end
end
