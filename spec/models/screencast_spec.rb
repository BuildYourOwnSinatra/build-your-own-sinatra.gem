describe Screencast do
  describe '.new' do
    it 'returns a new instance of Screencast' do
      expect(Screencast.new).to be_instance_of Screencast
    end
  end

  describe '.create' do
    after(:each) do
      Screencast.destroy_all
    end

    context 'when data is valid' do
      it 'saves a screencast' do
        screencast = FactoryGirl.create(:screencast)
        screencast = Screencast.first id: screencast.id
        expect(screencast).to be_instance_of Screencast
      end
    end
  end
end
