class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.text :target
      t.text :short
      t.text :title

      t.timestamps
    end
  end
end
