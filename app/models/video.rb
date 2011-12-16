class Video < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy

  has_attached_file :video, styles: { original: { } },
                            :path => ":rails_root/public/system/:attachment/:id/:style/:name_with_changed_extension",
                            :url => "/system/:attachment/:id/:style/:name_with_changed_extension",
                            processors: [:video_converter]

      Paperclip.interpolates :name_with_changed_extension do |attachment, style|
        attachment.instance.change_extension
      end

  validates :title, presence: true, length: 5..100
  validates :user, presence: true
  validates :description, length: { maximum: 1000 }
  validates_attachment_presence :video
  validates_attachment_content_type :video, content_type: /video/, message: "invalid"
  validates_attachment_size :video, less_than: 100.megabyte

  self.per_page = 5

  def change_extension
    File.basename(File.basename(self.video_file_name), File.extname(self.video_file_name)) + '.flv'
  end
end
