describe Purchase do
  describe '.new' do
    it 'returns a new instance of Purchase' do
      expect(Purchase.new).to be_instance_of Purchase
    end
  end

  describe '.create' do
    after(:each) do
      Purchase.destroy_all
    end

    context 'when data is valid' do
      it 'saves a purchase' do
        purchase = FactoryGirl.create(:purchase)
        purchase = Purchase.first id: purchase.id
        expect(purchase).to be_instance_of Purchase
      end

      describe 'returns a new purchase' do
        subject(:purchase) { FactoryGirl.create(:purchase_with_user_and_package) }

        it 'belongs to a user' do
          expect(purchase.user).to be_instance_of User
        end

        it 'has a package' do
          expect(purchase.package).to be_instance_of Package
        end
      end
    end
  end

  describe '#upgrade!' do
    subject(:purchase) { FactoryGirl.create(:purchase_with_package) }
    let(:package) { FactoryGirl.create(:package) }

    before do
      @original_package = purchase.package
      purchase.upgrade! package, 'charge-id'
    end

    it 'pushes the upgraded package onto #package_ids' do
      expect(purchase.package_ids).to include(@original_package.id)
    end

    it 'sets #upgraded= to true' do
      expect(purchase.upgraded).to eql(true)
    end

    it 'sets #package= to the package' do
      expect(purchase.package.id).to eql(package.id)
    end

    it 'saves #upgraded' do
      purchase.reload
      expect(purchase.upgraded).to eql(true)
    end
  end

  describe '#refund!' do
    subject(:purchase) { FactoryGirl.create(:purchase) }
    let(:stripe_refund) { OpenStruct.new(id: 'stripeyRefund') }

    before(:each) do
      purchase.refund!(stripe_refund)
    end

    it 'sets #refunded= to true' do
      expect(purchase.refunded).to eql(true)
    end

    it 'saves #refunded' do
      purchase.reload
      expect(purchase.refunded).to eql(true)
    end
  end
end
