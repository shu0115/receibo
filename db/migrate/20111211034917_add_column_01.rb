class AddColumn01 < ActiveRecord::Migration
  def self.up
    add_column :items, :buy_date, :timestamp
  end

  def self.down
  end
end
