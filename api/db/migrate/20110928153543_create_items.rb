class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.datetime :done_at
      t.references :user
      t.references :list
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
