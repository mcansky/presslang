class CreateDefinitions < ActiveRecord::Migration
  def self.up
    create_table :definitions do |t|
      t.text :definition
      t.text :word_id
      t.string :author
      t.string :sha
      t.string :twitter_id
      t.datetime :twitted_at
      t.boolean :banned, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :definitions
  end
end
