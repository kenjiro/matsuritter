class CreateDesignThemes < ActiveRecord::Migration
  def self.up
    create_table :design_themes do |t|
      t.binary :image ,:null =>false
      t.boolean :delete_flg , :default  => 0
      t.timestamps
      t.integer :lock_version, :default  => 0
    end
  end

  def self.down
    drop_table :design_themes
  end
end
