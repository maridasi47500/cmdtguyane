class CreateArtcat < ActiveRecord::Migration[6.0]
  def change
    create_table :artcats do |t|
      t.string :title
      t.string :url
    end
  end
end
