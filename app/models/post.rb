class Post < ActiveRecord::Base
  belongs_to :video

  validates :message, :video, presence: true
  validates :name, length: { maximum: 20 }
  validates :message, length: { maximum: 500 }

  before_save :set_name

  private

  def set_name
    self.name = 'Anonymous' if self.name.empty?
  end
end
