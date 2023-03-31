class CreateUrlVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :url_visits do |t|
      t.references :url, null: false, foreign_key: true
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
