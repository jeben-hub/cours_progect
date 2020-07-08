class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.string :name
      t.text :body
      t.references :fanfic, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
