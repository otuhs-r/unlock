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
      context '新しい実績が作成される場合' do
        let(:user) { create(:user) }
        let(:achievement) { create(:achievement) }
        before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

        it 'リクエストが成功する' do
          post achievements_url, params: { achievement: attributes_for(:achievement) }
          expect(response.status).to eq 302
        end

        it '実績が登録される' do
          expect do
            post achievements_url, params: { achievement: attributes_for(:achievement) }
          end.to change(Achievement, :count).by(1)
        end

        it 'ブックマークされる' do
          expect do
            post achievements_url, params: { achievement: attributes_for(:achievement) }
          end.to change(Bookmark, :count).by(1)
        end

        context '登録のみの場合' do
          it 'ユーザーページにリダイレクトする' do
            post achievements_url, params: { achievement: attributes_for(:achievement), only_create: '' }
            expect(response).to redirect_to user_url(user)
          end
        end

        context '登録かつ解除の場合' do
          it '実績解除ページにリダイレクトする' do
            post achievements_url, params: { achievement: attributes_for(:achievement) }
            expect(response).to redirect_to user_bookmark_path(user, Bookmark.last)
          end
        end
      end

      context 'すでに実績が存在する場合' do
        let(:user) { create(:user) }
        let!(:achievement) { create(:achievement) }
        before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

        it 'リクエストが成功する' do
          post achievements_url, params: { achievement: attributes_for(:achievement) }
          expect(response.status).to eq 302
        end

        it '実績が登録されない' do
          expect do
            post achievements_url, params: { achievement: attributes_for(:achievement) }
          end.to change(Achievement, :count).by(0)
        end

        context 'ブックマーク済の場合' do
          let!(:bookmark) { create(:bookmark, user: user, achievement: achievement) }

          it 'ブックマークされない' do
            expect do
              post achievements_url, params: { achievement: attributes_for(:achievement) }
            end.to change(Bookmark, :count).by(0)
          end
        end

        context 'ブックマークしていない場合' do
          it 'ブックマークされる' do
            expect do
              post achievements_url, params: { achievement: attributes_for(:achievement) }
            end.to change(Bookmark, :count).by(1)
          end
        end
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
