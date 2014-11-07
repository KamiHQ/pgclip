class AddErrorToResult < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.string :error
    end
  end
end
