class Reference < ActiveRecord::Base

  belongs_to :topic

  validates :URL, presence: true

end
