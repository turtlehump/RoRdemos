class Professor < ActiveRecord::Base

  has_many :ratings, dependent: :destroy
#  accepts_nested_attributes_for :ratings

  def name
    first + ' ' + last
  end

end
