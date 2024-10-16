class CreateMusics < ActiveRecord::Migration[7.2]
  def change
    create_table :musics do |t|
      t.string :title, null: false
      t.string :album_name, null: false
      t.string :genre, null: false
      t.belongs_to :singer

      t.timestamps
    end
  end
end
