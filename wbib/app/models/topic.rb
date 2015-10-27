class Topic < ActiveRecord::Base

  has_many :references, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :references

end
