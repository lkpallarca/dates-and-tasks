class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :target_date
end
