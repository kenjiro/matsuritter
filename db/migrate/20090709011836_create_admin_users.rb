class CreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table :admin_users do |t|
      t.string :login_account ,:null => false ,:limit =>50
      t.string :pass ,:null => false ,:limit =>50
      t.string :name ,:null => false
      t.timestamps
      t.string :lock_version
      t.boolean :delete_flg , :default  => 0
    end
  end

  def self.down
    drop_table :admin_users
  end
end
