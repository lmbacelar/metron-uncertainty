class AddUrlToModels < ActiveRecord::Migration
  def change
    add_column :models, :url, :string
    add_index  :models, :url
  end
end
