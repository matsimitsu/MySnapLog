class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :site_id
      t.integer :user_id
      t.boolean :receive_comment_notifications

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
