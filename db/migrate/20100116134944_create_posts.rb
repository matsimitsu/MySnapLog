class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :site_id
      t.integer :user_id
      t.string :title
      t.string :description
      t.integer :likes
      t.date :pubdate
      t.integer :comment_count

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
