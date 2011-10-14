require 'bundler/setup'

Bundler.setup

require 'sinatra'
require 'json'
require 'net/http'
require 'uri'
require 'json'
require 'cgi'
require 'erb'
require 'rexml/document'
require 'htmlentities'

require './printer'
require './fetcher'

require './presenter'
require './get_presenter'
require './post_presenter'

require './web'

run Rack::URLMap.new({
  '/public' => Rack::Directory.new('public'),
  '/'    => Fuzzer.new
})

