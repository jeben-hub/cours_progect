class AddThemeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :dark_theme, :boolean, default: false
  end
end
