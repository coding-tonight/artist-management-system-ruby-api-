class CreateSingers < ActiveRecord::Migration[7.2]
  def change
    create_table :singers do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.date :dob
      t.string :gender
      t.string :address
      t.date :first_release_year
      t.integer :no_of_albums_released

      t.timestamps
    end
  end
end
