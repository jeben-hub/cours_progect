class AddPictureToChapter < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :picture, :string
  end
end
