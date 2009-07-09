class CreateMails < ActiveRecord::Migration
  def self.up
    create_table :mails do |t|
      t.integer :send_user_id ,:null => false
      t.integer :receive_user_id ,:null => false
      t.integer :return_mails_id ,:null => false
      t.string :subject ,:size => 500
      t.integer :res_flg ,:null => false
      t.integer :direct_receive_mail_id
      t.text :message
      t.boolean :delete_flg , :default  => 0
      t.timestamps
       t.integer :lock_version, :default  => 0
    end
  end

  def self.down
    drop_table :mails
  end
end
