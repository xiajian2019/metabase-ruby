# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'metabase/error'

module Metabase
  module Connection
    def get(path, **params)
      request(:get, path, params)
    end

    def post(path, **params)
      request(:post, path, params)
    end

    def put(path, **params)
      request(:put, path, params)
    end

    def delete(path, **params)
      request(:delete, path, params)
    end

    def head(path, **params)
      request(:head, path, params)
    end

    private

    def request(method, path, params)
      headers = params.delete(:headers)
      body = params.delete(:body) # 单独提取 body 参数

      response = connection.public_send(method, path, params) do |request|
        request.headers['X-Metabase-Session'] = @token if @token
        headers&.each_pair { |k, v| request.headers[k] = v }

        # 根据请求方法设置 body 或 params
        if [:post, :put, :patch].include?(method)
          request.body = body || params.to_json # 支持直接传 body 或自动转 JSON
        else
          request.params = params # GET/DELETE 等请求的参数放在 URL 查询字符串中
        end
      end

      error = Error.from_response(response)
      raise error if error

      response.body
    end

    def connection
      @connection ||= Faraday.new(url: @url) do |c|
        c.request :json, content_type: /\bjson$/
        c.response :json, content_type: /\bjson$/
        c.request :url_encoded, content_type: /x-www-form-urlencoded/
        c.adapter Faraday.default_adapter
        c.headers['User-Agent'] =
          "MetabaseRuby/#{VERSION} (#{RUBY_ENGINE}#{RUBY_VERSION})"
      end
    end
  end
end
