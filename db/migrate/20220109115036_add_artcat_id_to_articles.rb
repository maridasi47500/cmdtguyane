class AddArtcatIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :artcat_id, :integer
  end
end
