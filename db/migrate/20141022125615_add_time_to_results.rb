class AddTimeToResults < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.decimal :execution_time
    end
  end
end
