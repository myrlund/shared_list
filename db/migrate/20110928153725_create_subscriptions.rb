class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :list_id
      t.integer :role_id

      t.timestamps
    end
  end
end
