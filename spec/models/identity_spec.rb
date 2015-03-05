describe Identity do
  describe '.new' do
    it 'returns a new instance of Identity' do
      identity = Identity.new
      expect(identity).to be_instance_of Identity
    end
  end

  describe '.create' do
    context 'when data is valid' do
      it 'saves a new Identity' do
        identity = FactoryGirl.create(:identity)
        identity = Identity.first id: identity.id
        expect(identity).to be_instance_of Identity
      end

      describe 'returns a new Identity' do
        it 'has a user' do
          identity = FactoryGirl.create(:identity_with_user)
          expect(identity.user).to be_instance_of User
        end
      end
    end

    context 'when data is invalid' do
      it 'returns an identity with errors' do
        identity = Identity.create
        expect(identity.errors['provider'].first).to eq "can't be blank"
      end
    end
  end

  describe '.find_with_omniauth' do
    context 'when an identity exists with the provider and uid' do
      it 'returns the identity' do
        identity = FactoryGirl.create(:identity)
        expect(Identity.find_with_omniauth(identity.attributes)).to be_instance_of Identity
      end
    end
  end

  describe '.create_with_omniauth' do
    it 'creates an identity from an auth hash' do
      identity = Identity.create_with_omniauth(gen_omniauth_hash)
      expect(identity).to be_instance_of Identity
      expect(identity.errors.messages).to be_empty
    end
  end

  describe '.find_or_create_with_omniauth' do
    context 'when identity exists' do
      it 'returns it' do
        auth = gen_omniauth_hash()
        identity_id = Identity.create_with_omniauth(auth).id
        identity = Identity.find_or_create_with_omniauth(auth)
        expect(identity.id).to eq(identity_id)
      end
    end

    context 'when identity does not exist' do
      it 'creates one and returns it' do
        identity_uid = Identity.create_with_omniauth(gen_omniauth_hash).uid
        identity = Identity.find_or_create_with_omniauth(gen_omniauth_hash)
        expect(identity.uid).to_not eq(identity_uid)
        expect(identity).to be_instance_of Identity
        expect(identity.errors.messages).to be_empty
      end
    end
  end
end
