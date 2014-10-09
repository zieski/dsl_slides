class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true
      t.string :name
      t.text :description
      t.string :priority

      t.timestamps
    end
  end
end
