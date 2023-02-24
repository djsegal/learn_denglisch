class CreateLemmas < ActiveRecord::Migration[7.0]
  def change
    create_table :lemmas do |t|
      t.string :name
      t.string :type
      t.string :audio
      t.references :word, null: false, foreign_key: true

      t.timestamps
    end
  end
end
