class AddParametersToResults < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.text :parameters, array: true
    end 
  end
end
