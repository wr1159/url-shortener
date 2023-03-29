class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :target
      t.string :short
      t.string :title

      t.timestamps
    end
  end
end
