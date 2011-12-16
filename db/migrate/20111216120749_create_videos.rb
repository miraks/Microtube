class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, null: false
      t.text :description
      t.string :video_file_name, null: false
      t.string :video_content_type, null: false
      t.integer :video_file_size, null: false

      t.timestamps
    end
  end
end
