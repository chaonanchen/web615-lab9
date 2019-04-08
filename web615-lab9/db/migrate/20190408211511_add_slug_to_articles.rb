class AddSlugToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :uuid, :string, unique: true, index: true
    add_column :articles, :slug, :string, unique: true, index: true

    Article.all.each do |article|
      uuid = SecureRandom.uuid
      article.update_column(:uuid, uuid)
      article.update_column(:slug, uuid)
    end
  end
end
