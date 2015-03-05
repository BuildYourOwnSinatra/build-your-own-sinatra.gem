class Screencast
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Sluggable

  key :name,     String
  key :file_url, String

  validates_presence_of :name
  validates_presence_of :file_url

  sluggable :name
end
