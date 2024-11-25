# frozen_string_literal: true

class Store
  def get(id)
    data = REDIS.get(key(id))
    JSON.parse(data) unless data.nil?
  end

  def set(id, data)
    REDIS.set(key(id), data) unless REDIS.exists?(key(id))
  end

  private

  def key(id)
    "Route:#{id}"
  end
end
