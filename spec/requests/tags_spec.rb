describe TagsController, type: :request do
  describe 'GET #index' do
    let!(:tag) { create(:tag) }

    it 'リクエストが成功する' do
      get tags_url
      expect(response.status).to eq 200
    end

    it 'タグ名が表示されている' do
      get tags_url
      expect(response.body).to include 'test_tag'
    end
  end

  describe 'GET #show' do
    context 'タグが存在する' do
      let!(:achievement) { create(:achievement) }
      let!(:tag) { create(:tag) }

      before do
        achievement.tag_list.add(tag)
        achievement.save
      end

      it 'リクエストが成功する' do
        get tag_url(tag)
        expect(response.status).to eq 200
      end

      it 'タグ名・ブックマーク名が表示される' do
        get tag_url(tag)
        expect(response.body).to include 'test_tag'
        expect(response.body).to include 'test_title'
      end
    end

    context 'タグが存在しない' do
      subject { -> { get tag_url(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
