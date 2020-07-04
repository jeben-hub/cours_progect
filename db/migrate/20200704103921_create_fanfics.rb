class CreateFanfics < ActiveRecord::Migration[6.0]
  def change
    create_table :fanfics do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
