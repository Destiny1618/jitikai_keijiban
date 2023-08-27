class CreateEventComments < ActiveRecord::Migration[6.1]
  def change
    create_table :event_comments do |t|
      t.integer :customer_id
      t.integer :asmin_id
      t.integer :event_id
      t.text :comment
      t.timestamps
    end
  end
end
