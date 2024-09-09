class CreateNewspapers < ActiveRecord::Migration[7.0]
  def change
    create_table :newspapers do |t|
      t.string :name
      t.string :url
      t.string :language

      t.timestamps
    end
  end
end
