require "rest-client"
require "json"

module CompanionCube
  class Client
    API_HEADERS = { "Accept" => "application/json" }.freeze

    def initialize(url:, access_key: nil, secret_key: nil)
      raise "Missing required parameter 'url'" if url.nil? || url.empty?

      keys_empty = !access_key.nil? && access_key.empty?
      keys_empty ||= !secret_key.nil? && secret_key.empty?
      raise "Access/secret key cannot be blank" if keys_empty

      self.resource = RestClient::Resource.new(url, access_key, secret_key)
    end

    def courses
      JSON.parse(send_request(:get, "/courses"))
    end

    def create_course(params)
      params[:multipart] = true

      send_request(:post, "/courses", body: params)
    end

    def delete_course(id)
      send_request(:delete, "/courses/#{id}")
    end

    def course(id)
      raise "Missing required parameter 'id'" if id.nil?

      JSON.parse(send_request(:get, "/courses/#{id}"))
    end

    def update_course(id, params)
      params[:multipart] = true

      send_request(:put, "/courses/#{id}", body: params)
    end

    def reports(type, params = {})
      raise "Missing required parameter 'type'" if type.nil?
      format = params.fetch(:format, :json).to_sym

      response = send_request(:get, "/reports/#{type}", params: params, accept: format)
      return JSON.parse(response) if format == :json
      # csv, etc.
      response
    end

    protected

    attr_accessor :resource

    def send_request(method, path, opts = {})
      body    = opts.fetch(:body, {})
      headers = opts.fetch(:headers, {}).merge(API_HEADERS)

      response = if %i[get delete].include?(method)
                   resource[path].send(method, opts)
                 else
                   resource[path].send(method, body, headers)
                 end

      response.body
    end
  end
end
