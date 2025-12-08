class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.references :category, null: false, foreign_key: true
      t.references :creator, index: true, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
