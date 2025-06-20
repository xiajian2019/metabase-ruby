# frozen_string_literal: true

require 'metabase/connection'
require 'metabase/endpoint'

module Metabase
  class Client
    include Connection
    include Endpoint

    def initialize(url:, username: nil, password: nil, token: nil, debug: false)
      @url = url
      @username = username
      @password = password
      @token = token
      @debug = debug
    end
  end
end
