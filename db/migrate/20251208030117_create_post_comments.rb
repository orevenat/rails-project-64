class CreatePostComments < ActiveRecord::Migration[8.1]
  def change
    create_table :post_comments do |t|
      t.references :creator, index: true, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: true
      t.text :content

      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        t.string :ancestry, null: false, collation: 'C'
      else
        t.string :ancestry, null: false
      end
      t.index 'ancestry'

      t.timestamps
    end
  end
end
