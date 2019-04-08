class AddSlugToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :uuid, :string, unique: true, index: true
    add_column :comments, :slug, :string, unique: true, index: true

    Comment.all.each do |comment|
      uuid = SecureRandom.uuid
      comment.update_column(:uuid, uuid)
      comment.update_column(:slug, uuid)
    end
  end
end
