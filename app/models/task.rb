class Task < ApplicationRecord
  belongs_to :category
  
  attribute :status, :boolean, default: false
end
