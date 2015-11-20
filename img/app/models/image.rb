class Image < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  has_many :image_users, dependent: :destroy
  has_many :users, through: :image_users
  belongs_to :user
  validates :name, presence: true

  def generate_filename
    t = Time.now
    filename = t.year + t.month + t.day + t.hour + t.min + t.sec + t.usec
    write_attribute(:filename, filename)
  end
end
