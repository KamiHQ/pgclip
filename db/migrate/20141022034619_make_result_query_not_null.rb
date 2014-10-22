class MakeResultQueryNotNull < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.change :query_id, :uuid, null: false
    end
  end
end
