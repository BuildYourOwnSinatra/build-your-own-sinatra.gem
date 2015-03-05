describe Package do
  describe '.new' do
    it 'returns a new instance of Package' do
      expect(Package.new).to be_instance_of Package
    end
  end

  describe '.create' do
    after(:each) do
      Package.destroy_all
    end

    context 'when data is valid' do
      it 'saves a package' do
        package = Package.create(price: 20, name: 'name')
        package = Package.first id: package.id
        expect(package).to be_instance_of Package
      end

      describe 'returns a new package' do
        subject(:package) { Package.create(price: 20, name: 'cats dogs') }

        it 'has a slug' do
          expect(package.slug).to eq('cats-dogs')
        end
      end
    end

    context 'when data is invalid' do
      it 'returns a package with errors' do
        package = Package.create(price: 20)
        expect(package.errors['name'].first).to eq "can't be blank"
      end
    end
  end
end
