class Task < ApplicationRecord
  belongs_to :category
  has_many :users, through: :user_tasks
  
  attribute :status, :boolean, default: false
end
