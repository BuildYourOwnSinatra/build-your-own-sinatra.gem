class Identity
  include MongoMapper::Document
  key :email,           String
  key :username,        String
  key :name,            String
  key :password_digest, String
  key :provider,        String
  key :uid,             String
  key :avatar,          String

  belongs_to :user

  validates_presence_of :provider, :email, :username

  def self.find_with_omniauth(auth)
    first(uid: auth['uid'], provider: auth['provider'])
  end

  def uid
    return self.id.to_s if self[:uid].nil?
    self[:uid]
  end

  def self.find_or_create_with_omniauth(auth)
    identity  = find_with_omniauth(auth)
    identity ||= create_with_omniauth(auth)
    identity
  end

  def self.create_with_omniauth(auth)
    create do |identity|
      identity.provider = auth.provider
      identity.uid      = auth.uid
      identity.name     = auth.info.name
      identity.email    = auth.info.email
      identity.username = auth.info.nickname
      identity.avatar   = auth.image
    end
  end
end
