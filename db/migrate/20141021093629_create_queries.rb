class CreateQueries < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :queries, id: :uuid do |t|
      t.text :query, null: false

      t.integer :ttl_minutes, null: false, default: 10

      t.timestamps
    end
  end
end
