class AddFilePathToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :file_path, :string
  end
end
