# frozen_string_literal: true

# t.bigint "id"
# t.string "title"
# t.string "origin" # у форматі "latitude:longitude"
# t.string "destination" # у форматі "latitude:longitude"
# t.timestamp "last_updated_at"
class Route < ApplicationRecord
  before_create :set_last_updated

  def set_last_updated
    self.last_updated_at = Time.now
  end
end
