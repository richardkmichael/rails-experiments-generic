class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.references :car, index: true

      t.timestamps null: false
    end
    add_foreign_key :parts, :cars
  end
end
