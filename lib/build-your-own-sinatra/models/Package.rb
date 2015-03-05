require 'mm-sluggable'

class Package
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Sluggable

  key :price,          Integer
  key :name,           String
  key :chapters,       Array # Array of chapter slugs redable with this package
  key :screencast_ids, Array

  validates_presence_of :price
  validates_presence_of :name
  sluggable :name

  belongs_to :purchase
  many :screencasts, in: :screencast_ids
end
