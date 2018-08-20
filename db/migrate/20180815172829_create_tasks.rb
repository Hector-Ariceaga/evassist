class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.boolean :completed
      t.integer :event_id
      t.integer :user_id
    end
  end
end
