class CreateArticlesTable < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :url, null: false
      t.string :text
      t.string :title
      t.string :author
      t.belongs_to :user, index: true, null: false

      t.timestamps

      t.index :url
    end
  end
end
