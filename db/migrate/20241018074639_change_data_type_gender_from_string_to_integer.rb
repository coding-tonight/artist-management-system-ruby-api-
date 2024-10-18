class ChangeDataTypeGenderFromStringToInteger < ActiveRecord::Migration[7.2]
  def up
    execute "ALTER TABLE singers ALTER gender DROP DEFAULT;"
    change_column :singers, :gender, :integer, using: 'gender::integer'
  end
end
