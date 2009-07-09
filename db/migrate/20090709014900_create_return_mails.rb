class CreateReturnMails < ActiveRecord::Migration
  def self.up
    create_table :return_mails do |t|
      t.integer :mail_id
      t.timestamps
      t.integer :lock_version
      t.boolean :delete_flg , :default  => 0
    end
  end

  def self.down
    drop_table :return_mails
  end
end
