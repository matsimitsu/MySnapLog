class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.string :description
      t.string :analytics_key
      t.string :domain
      t.integer :owner_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
