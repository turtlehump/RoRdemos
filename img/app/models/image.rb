class Image < ActiveRecord::Base
  has_many :tags
  has_many :image_users, dependent: :destroy
  belongs_to :user
end
