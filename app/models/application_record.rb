class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :recientes_primero, -> { order(created_at: :desc) }

end
