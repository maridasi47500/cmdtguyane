class AddTypeToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :type, :string
  end
end
