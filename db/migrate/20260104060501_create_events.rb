class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :latitude, precision: 10, scale: 6
      t.text :briefing, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
