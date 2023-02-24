class AddSeasonNumberToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :season_number, :integer
  end
end
