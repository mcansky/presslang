class ChangeBanned < ActiveRecord::Migration
  def self.up
    remove_column :definitions, :banned
    add_column :definitions, :banned, :string, :default => "n"
  end

  def self.down
    remove_column :definitions, :banned
    add_column :definitions, :banned, :boolean, :default => false
  end
end
