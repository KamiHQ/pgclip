class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.uuid :query_id
      t.text :result

      t.timestamps
    end
  end
end
