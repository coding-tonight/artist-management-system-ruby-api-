class ChangeDatTypeOfGenreMusic < ActiveRecord::Migration[7.2]
  def up
    execute "ALTER TABLE musics ALTER genre DROP DEFAULT;"
    change_column :musics, :genre, :integer, using: 'genre::integer'
  end
end
