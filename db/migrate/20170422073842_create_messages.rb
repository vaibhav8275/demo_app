class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.text :message_detail
      t.integer :sent_by_id, index: true
      t.integer :recieved_by_id, index: true

      t.timestamps null: false
    end
  end
end
