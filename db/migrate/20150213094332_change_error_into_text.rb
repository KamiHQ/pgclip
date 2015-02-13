class ChangeErrorIntoText < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.change :error, :text
    end
  end
end
