# frozen_string_literal: true

class Direction

  def initialize(static_duration:, distance:)
    @updated_at = Time.zone.now
    @static_duration = static_duration
    @duration = duration
    @distance = distance
    @speed = speed
    @traffic_state = traffic_state
  end

  def to_json
    {
      updated_at: @updated_at,
      static_duration: @static_duration,
      duration: @duration,
      distance: @distance,
      speed: @speed,
      traffic_state: @traffic_state
    }.to_json
  end
end
