class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :pass ,:null => false ,:size =>45
      t.string :name,:null => false
      t.string :mail,:null => false
      t.string :other_url
      t.string :self_introduction
      t.string :now_place
      t.boolean :follow_news_flg
      t.boolean :dm_news_flg
      t.boolean :nesw_letter_flg
      t.binary :design_theme_id
      t.binary :icon_image_id
      t.boolean :delete_flg , :default  => 0
      t.timestamps
      t.integer :lock_version
    end

  end

  def self.down
    drop_table :users
  end
end
