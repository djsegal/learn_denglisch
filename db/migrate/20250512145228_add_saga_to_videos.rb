class AddSagaToVideos < ActiveRecord::Migration[7.0]
  def change
    add_reference :videos, :saga, null: false, foreign_key: true
  end
end
