class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :name
      t.integer :article_id
      t.string :email
      t.text :body

      t.timestamps null: false
    end
  end
end
