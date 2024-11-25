# frozen_string_literal: true

require 'redis'

REDIS = Redis.new(url: Rails.application.config_for(:redis)['url'])
