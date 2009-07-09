class CreateNewsLetters < ActiveRecord::Migration
  def self.up
    create_table :news_letters do |t|
      t.string :subject
      t.text :body
      t.boolean :preview_flg
      t.boolean :delete_flg , :default  => 0
      t.datetime :send_at
      t.timestamps
      t.integer :lock_version
    end
  end

  def self.down
    drop_table :news_letters
  end
end
