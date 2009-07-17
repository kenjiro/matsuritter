class CreateMutters < ActiveRecord::Migration
  def self.up
    create_table :mutters do |t|
      t.integer :user_id ,:null => false
      t.boolean :res_flg, :null  => false ,:default => 0
      t.integer :return_mutter_id
      t.text :mutter,:limit =>500
      t.binary  :image
      t.boolean :delete_flg , :default  => 0
      t.timestamps
      t.integer :lock_version, :default  => 0
    end
  end

  def self.down
    drop_table :mutters
  end
end
