class CreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table :admin_users do |t|
      t.string :login_account ,:limit =>45
      t.string :pass ,:limit => 45
      t.string :name
      t.timestamps
      t.string :lock_version
      t.boolean :delete_flg , :default  => 0
    end
  end

  def self.down
    drop_table :admin_users
  end
end
