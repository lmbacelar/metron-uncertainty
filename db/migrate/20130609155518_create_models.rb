class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name       , null: false, unique: true
      t.text   :description
      t.text   :equation   , null: false, unique: true

      t.timestamps
      
      t.index  :name
    end
  end
end
