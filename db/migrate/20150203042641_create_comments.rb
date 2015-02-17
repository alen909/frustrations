class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :frustration, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :frustrations
  end
end
