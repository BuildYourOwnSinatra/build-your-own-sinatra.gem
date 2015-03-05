describe User do
  describe '.new' do
    it 'returns a new instance' do
      expect(User.new).to be_instance_of User
    end
  end

  describe '.create_with_identity' do
    it 'creates a new user' do
      identity = FactoryGirl.create(:identity)
      user = User.create_with_identity(identity)
      expect(user).to be_instance_of User
      expect(user.identity_ids.first).to eq(identity.id)
    end
  end

  describe '#can_read_chapter?' do
    it 'returns false when there are no packages' do
      user = FactoryGirl.create(:user)
      expect(user.can_read_chapter?('bob')).to eq false
    end

    it 'returns true when a chapter can be read' do
      user = FactoryGirl.create(:user_with_purchases)
      package = FactoryGirl.create(:package, chapters: ['bob'])
      user.purchases.first.packages << package
      expect(user.can_read_chapter?('bob')).to eq false
    end
  end
end
