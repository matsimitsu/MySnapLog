class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.string :name
      t.string :email
      t.text :body
      t.boolean :spam, :default => 0
      t.string :ip
      t.string :hostname
      t.boolean :approved, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
