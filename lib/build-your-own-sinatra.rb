require 'mongo_mapper'
require 'omniauth-identity'
require_relative 'build-your-own-sinatra/ext/omniauth-identity/model'
require_relative 'build-your-own-sinatra/ext/omniauth-identity/secure_password'

ENV['RACK_ENV']    ||= 'development'
ENV['MONGODB_URI'] ||= 'mongodb://localhost:27017/byos'
MongoMapper.setup({ ENV['RACK_ENV'] => { 'uri' => ENV['MONGODB_URI'] } }, ENV['RACK_ENV'])

require_relative 'build-your-own-sinatra/models/Identity'
require_relative 'build-your-own-sinatra/models/Package'
require_relative 'build-your-own-sinatra/models/Purchase'
require_relative 'build-your-own-sinatra/models/Screencast'
require_relative 'build-your-own-sinatra/models/User'
