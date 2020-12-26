# frozen_string_literal: true

require 'bundler/setup'

APP_ENV = ENV['RACK_ENV'] || 'development'

Bundler.require :default, APP_ENV.to_sym

require 'sinatra'
require 'sinatra/base'
require 'sinatra/json'
require 'slim'
require 'warden'
require 'rack/protection'

require 'dotenv'
Dotenv.load
