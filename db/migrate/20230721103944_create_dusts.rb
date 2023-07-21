class CreateDusts < ActiveRecord::Migration[6.1]
  def change
    create_table :dusts do |t|
      t.integer "topic_id"
      t.integer "admin_id"
      t.integer "customer_id"
      t.string "title"
      t.text "body"
      t.string "name"
      t.timestamps
    end
  end
end
