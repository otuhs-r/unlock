describe UsersController, type: :request do
  describe 'GET #ogp' do
    it 'リクエストが成功する' do
      get iamges_ogp_url
      expect(response.status).to eq 200
    end

    it 'ダウンロードされる' do
      get iamges_ogp_url
      expect(response.content_type).to eq('image/png')
    end
  end
end
