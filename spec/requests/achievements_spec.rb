describe AchievementsController, type: :request do
  describe 'GET #index' do
    before do
      create(:marriage)
      create(:childbirth)
    end

    it 'リクエストが成功する' do
      get achievements_url
      expect(response.status).to eq 200
    end

    it '実績タイトルが表示されている' do
      get achievements_url
      expect(response.body).to include 'Marriage'
      expect(response.body).to include 'Childbirth'
    end
  end

  describe 'GET #new' do
    it 'リクエストが成功する' do
      allow_any_instance_of(ApplicationController).to receive(:login_required)
      get new_achievement_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      before { allow_any_instance_of(ApplicationController).to receive(:login_required) }

      it 'リクエストが成功する' do
        post achievements_url, params: { achievement: attributes_for(:achievement) }
        expect(response.status).to eq 302
      end

      it '実績が登録される' do
        expect do
          post achievements_url, params: { achievement: attributes_for(:achievement) }
        end.to change(Achievement, :count).by(1)
      end

      it 'リダイレクトする' do
        post achievements_url, params: { achievement: attributes_for(:achievement) }
        expect(response).to redirect_to achievements_url
      end
    end

    context 'パラメータが不正な場合' do
      before { allow_any_instance_of(ApplicationController).to receive(:login_required) }

      it 'リクエストが成功する' do
        post achievements_url, params: { achievement: attributes_for(:achievement, :invalid) }
        expect(response.status).to eq 200
      end

      it '実績が登録されない' do
        expect do
          post achievements_url, params: { achievement: attributes_for(:achievement, :invalid) }
        end.to_not change(Achievement, :count)
      end
    end
  end
end
