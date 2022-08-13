class CreateArticle < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :image
      t.text :content
      t.string :auteur
      t.date :date
      t.integer :vues
      t.timestamps
    end
  end
end
