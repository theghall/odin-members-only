class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
      t.boolean :flagged

      t.timestamps
    end
    add_index :posts, [:user_id, :title], unique: true
  end
end
