class CreateFollows < ActiveRecord::Migration
  def self.up
    create_table :follows do |t|
      t.integer :user_id ,:null => false
      t.integer :follow_user_id , :null => false
      t.boolean :delete_flg , :default  => 0
      t.timestamps
      t.integer :lock_version
    end
  end

  def self.down
    drop_table :follows
  end
end
