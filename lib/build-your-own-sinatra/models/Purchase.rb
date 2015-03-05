class Purchase
  include MongoMapper::Document

  key :charge_id,   String
  key :price,       Integer
  key :refunded,    Boolean, default: false
  key :refund_id,   String
  key :upgraded,    Boolean, default: false
  key :package_ids, Array
  key :chapters,    Array

  many :packages, in: :package_ids
  belongs_to :user

  def upgrade(upgrade_package, charge_id)
    self.upgraded  = true
    self.packages << upgrade_package
    self.charge_id = charge_id
  end

  def package
    Package.find(package_ids.last)
  end

  def upgrade!(upgrade_package, charge_id)
    upgrade(upgrade_package, charge_id)
    save
  end

  def refund(stripe_refund)
    self[:refund_id] = stripe_refund.id
    self[:refunded] = true
  end

  def refund!(stripe_refund)
    refund(stripe_refund)
    save
  end
end
