require "mocktra/version"
require 'webmock'
require 'sinatra/base'

WebMock.allow_net_connect!

module Mocktra
  class << self
    def mocktra(pattern, &block)
      # TODO
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