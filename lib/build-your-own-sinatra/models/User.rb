class User
  include MongoMapper::Document

  ## Basic Details
  key :username,  String
  key :name,      String
  key :avatar,    String
  key :email,     String
  key :roles,     Array

  ## Associations
  key :identity_ids, Array

  ## Stripe
  key :stripe_id, String

  belongs_to :identity
  many   :purchases
  many   :identities, in: :identity_ids

  validates_uniqueness_of :username

  def self.create_with_identity(identity)
    create do |user|
      user.name     = identity.name
      user.email    = identity.email
      user.username = identity.username
      user.avatar   = identity.avatar
      user.identities << identity
    end
  end

  def package
    return nil unless purchases.first
    purchases.first.package
  end

  def role?(roles)
    roles = [roles] if roles.is_a? Symbol
    (self[:roles] & roles).empty?
  end
  alias_method :has_role?, :role?

  def can_read_chapter?(chapter_slug)
    return false unless package
    package.chapters.include? chapter_slug
  end
end
