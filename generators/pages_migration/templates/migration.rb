class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.datetime :published_at
      t.datetime :published_to
      t.text :body
      t.string :description
      t.string :template, :limit => 20
      t.integer :position, :default => 0
      t.references :created_by, :updated_by, :parent
      t.integer :lock_level, :default => 0

      t.timestamps
    end

    add_index :pages, :permalink

  end

  def self.down
    drop_table :pages
  end
end