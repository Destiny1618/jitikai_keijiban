class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :favoriteable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
