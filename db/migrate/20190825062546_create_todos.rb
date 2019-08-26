class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.integer :todo_status_id
      t.integer :project_id
      t.integer :user_id
      t.timestamps
    end
  end
end
