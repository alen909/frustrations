class CreateFrustrations < ActiveRecord::Migration
  def change
    create_table :frustrations do |t|
      t.string :title
      t.text :body
      t.string :cover
      t.integer :user_id, default: 1

      t.timestamps null: false
    end
  end
end
