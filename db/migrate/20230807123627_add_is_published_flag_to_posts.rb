class AddIsPublishedFlagToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_published_flag, :boolean, null: false, default: false
  end
end
