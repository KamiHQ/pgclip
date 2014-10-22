class AddNameToQuery < ActiveRecord::Migration
  def change
    change_table :queries do |t|
      t.string :name
    end
  end
end
