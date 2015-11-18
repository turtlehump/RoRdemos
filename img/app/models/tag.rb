class Tag < ActiveRecord::Base
  belongs_to :image
  validates :str, presence: true
end
