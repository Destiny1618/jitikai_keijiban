class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer "topic_id"
      t.integer "admin_id"
      t.integer "customer_id"
      t.string "title"
      t.text "body"
      t.string "name"
      t.boolean :is_published_flag, null: false, default: false
      t.timestamps
    end
  end
end
