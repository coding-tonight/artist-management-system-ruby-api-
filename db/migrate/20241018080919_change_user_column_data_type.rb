class ChangeUserColumnDataType < ActiveRecord::Migration[7.2]
  def up
    execute "ALTER TABLE users ALTER gender DROP DEFAULT, ALTER role DROP DEFAULT;"
    change_column :users, :gender, :integer, using: 'gender::integer'
    change_column :users, :role, :integer, using: 'role::integer'
  end
end
