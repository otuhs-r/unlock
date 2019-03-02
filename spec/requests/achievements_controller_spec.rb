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

  describe 'GET #show' do
    context '実績が存在する場合' do
      let(:marriage) { create(:marriage) }

      it 'リクエストが成功する' do
        get achievement_url(marriage.id)
        expect(response.status).to eq 200
      end

      it '実績タイトルが表示されている' do
        get achievement_url(marriage.id)
        expect(response.body).to include 'Marriage'
      end
    end

    context '実績が存在しない場合' do
      subject { -> { get achievement_url(1) } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
=begin
  describe 'GET #new' do
    let(:user) { create(:user) }

    it 'リクエストが成功する' do
      get new_achievement_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
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
        expect(response).to redirect_to Achievement.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功する' do
      end

      it '実績が登録されない' do
      end
    end
  end 
=end
end
