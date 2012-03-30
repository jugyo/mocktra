require "mocktra/version"
require 'webmock'
require 'sinatra/base'

WebMock.allow_net_connect!

module Mocktra
  class << self
    def mocktra(pattern, &block)
      pattern = case pattern
        when Regexp
          pattern
        when /^http/
          /^#{Regexp.quote(pattern)}/
        else
          /#{Regexp.quote(pattern)}/
        end
      rack_app = Class.new(Sinatra::Base, &block)
      WebMock::API.stub_request(:any, pattern).to_rack(rack_app)
    end
  end
end

module Kernel
  def Mocktra(*args, &block)
    Mocktra.mocktra(*args, &block)
  end
end

# patch to support basic auth
class WebMock::RackResponse
  def build_rack_env_with_basic_auth_support(request)
    env = build_rack_env_without_basic_auth_support(request)
    uri = request.uri
    env['HTTP_AUTHORIZATION'] = 'Basic ' + [uri.userinfo].pack('m').delete("\r\n") if uri.userinfo
    env
  end
  alias_method :build_rack_env_without_basic_auth_support, :build_rack_env
  alias_method :build_rack_env, :build_rack_env_with_basic_auth_support
end