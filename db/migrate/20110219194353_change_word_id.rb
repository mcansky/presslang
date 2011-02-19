class ChangeWordId < ActiveRecord::Migration
  def self.up
    remove_column :definitions, :word_id
    add_column :definitions, :word_id, :integer
  end

  def self.down
    remove_column :definitions, :word_id
    add_column :definitions, :word_id, :text
  end
end
