class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :input_message
      t.string :output_message
      t.string :language

      t.timestamps
    end
  end
end
