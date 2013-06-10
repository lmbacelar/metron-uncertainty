class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.string     :symbol,     index: true, null: false
      t.string     :name
      t.text       :description
      t.references :model,      index: true

      t.timestamps
    end
  end
end
