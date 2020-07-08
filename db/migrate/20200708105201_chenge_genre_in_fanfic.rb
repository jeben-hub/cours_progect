class ChengeGenreInFanfic < ActiveRecord::Migration[6.0]
  def change
    change_table :fanfics do |t|
      t.remove :genre
      t.references :genre, null: false, foreign_key: true, default: 3
    end
  end
end
