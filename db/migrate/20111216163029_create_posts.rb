class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :message
      t.integer :video_id

      t.timestamps
    end
  end
end
