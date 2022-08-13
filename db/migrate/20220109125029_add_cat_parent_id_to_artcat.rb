class AddCatParentIdToArtcat < ActiveRecord::Migration[6.0]
  def change
    add_column :artcats, :cat_parent_id, :integer
  end
end
