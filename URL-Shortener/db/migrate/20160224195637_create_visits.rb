class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.integer :short_url_id
      t.timestamps

    end
    add_index :visits, :user_id
  end
end
