class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :success, -> { where(result: "success")}

  default_scope { order(:id) }
  
end
