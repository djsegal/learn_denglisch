class CreateProxies < ActiveRecord::Migration[7.0]
  def change
    create_table :proxies do |t|
      t.string :url

      t.timestamps
    end
  end
end
