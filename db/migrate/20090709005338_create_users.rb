class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :pass ,:null => false ,:limit =>50
      t.string :name,:null => false ,:limit =>50
      t.string :mail,:null => false
      t.string :other_url
      t.string :self_introduction
      t.string :now_place
      t.boolean :follow_news_flg ,:default => 0
      t.boolean :dm_news_flg ,:default => 0
      t.boolean :news_letter_flg ,:default => 0
      t.integer :design_theme_id ,:default => 0
      t.binary :icon_image
      t.boolean :delete_flg , :default  => 0
      t.timestamps
      t.integer :lock_version, :default  => 0
    end

  end

  def self.down
    drop_table :users
  end
end
