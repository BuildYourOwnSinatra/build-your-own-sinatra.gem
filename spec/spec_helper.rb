lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
ENV['RACK_ENV'] = 'test'

require 'build-your-own-sinatra'
require 'ffaker'
require 'factory_girl'

FactoryGirl.definition_file_paths = [
  File.join(File.dirname(__FILE__), 'factories')
]
FactoryGirl.find_definitions

def gen_omniauth_hash
  OmniAuth::AuthHash.new({
    :provider => 'github',
    :uid      => Faker::Internet.user_name.gsub('.','') + rand(0...1000).to_s,
    :info     => {
      :email    => "#{Faker::Internet.user_name}_#{rand(0...1000)}@example.org",
      :nickname => 'hurley'
    }
    })
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = gen_omniauth_hash

def clean_db
  Identity.destroy_all
  Package.destroy_all
  Purchase.destroy_all
  User.destroy_all
end

clean_db()

module GlobalConfig
  extend RSpec::SharedContext
end

# Hardcode an instance into a global because rack-test likes to get too clever
RSpec.configure do |config|
  config.include GlobalConfig
  config.pattern = '**{,/*/**}/*_spec.rb'
end
