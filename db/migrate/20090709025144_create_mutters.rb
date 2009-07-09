class CreateMutters < ActiveRecord::Migration
  def self.up
    create_table :mutters do |t|
      t.integer :user_id ,:null => false
      t.integer :res_flg
      t.integer :return_mutters_id
      t.text :mutter,:size =>500
      t.binary  :image
      t.boolean :delete_flg , :default  => 0
      t.timestamps
      t.integer :lock_version
    end
  end

  def self.down
    drop_table :mutters
  end
end
