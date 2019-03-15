describe BookmarksController, type: :request do
  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      let(:user) { create(:user) }
      let(:achievement) { create(:achievement) }
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

      it 'リクエストが成功する' do
        post user_bookmarks_url(user), params: { bookmark: { achievement_id: achievement.id } }
        expect(response.status).to eq 302
      end

      it 'ブックマークが登録される' do
        expect do
          post user_bookmarks_url(user), params: { bookmark: { achievement_id: achievement.id } }
        end.to change(Bookmark, :count).by(1)
      end

      it 'リダイレクトする' do
        post user_bookmarks_url(user), params: { bookmark: { achievement_id: achievement.id } }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      let(:user) { create(:user) }
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

      it 'リクエストが成功する' do
        post user_bookmarks_url(user), params: { bookmark: { achievement_id: 1 } }
        expect(response.status).to eq 302
      end

      it 'ブックマークが登録されない' do
        expect do
          post user_bookmarks_url(user), params: { bookmark: { achievement_id: 1 } }
        end.to_not change(Bookmark, :count)
      end

      it 'リダイレクトする' do
        post user_bookmarks_url(user), params: { bookmark: { achievement_id: 1 } }
        expect(response).to redirect_to root_url
      end
    end

    context '他人のブックマークへのリクエストの場合' do
      let(:user) { create(:user) }
      let(:another_user) { create(:another_user) }
      let(:achievement) { create(:achievement) }
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

      it 'ブックマークが登録されない' do
        expect do
          post user_bookmarks_url(another_user), params: { bookmark: { achievement_id: achievement.id } }
        end.to_not change(Bookmark, :count)
      end

      it 'リダイレクトする' do
        post user_bookmarks_url(another_user), params: { bookmark: { achievement_id: achievement.id } }
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET #show' do
    context '解除済の実績の場合' do
      let(:user) { create(:user) }
      let(:achievement) { create(:achievement) }
      let(:bookmark) { create(:bookmark, status: :unlocked, user: user, achievement: achievement) }

      it 'リクエストが成功する' do
        get user_bookmark_path(user, bookmark)
        expect(response.status).to eq 200
      end

      it 'ユーザ名が表示されている' do
        get user_bookmark_path(user, bookmark)
        expect(response.body).to include 'test_user'
      end
    end

    context '未解除の実績の場合' do
      let(:user) { create(:user) }
      let(:achievement) { create(:achievement) }
      let(:bookmark) { create(:bookmark, user: user, achievement: achievement) }

      it 'リダイレクトする' do
        get user_bookmark_path(user, bookmark)
        expect(response).to redirect_to root_url
      end
    end

    context 'ブックマークが存在しない場合' do
      let(:user) { create(:user) }

      subject { -> { get user_bookmark_path(user, 1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'PATCH #update' do
    context 'パラメータが妥当な場合' do
      let(:user) { create(:user) }
      let(:achievement) { create(:achievement) }
      let(:bookmark) { create(:bookmark, user: user, achievement: achievement) }
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

      it 'リクエストが成功する' do
        patch user_bookmark_url(user, bookmark)
        expect(response.status).to eq 302
      end

      it '実績が解除される' do
        expect do
          patch user_bookmark_url(user, bookmark)
        end.to change { Bookmark.find(bookmark.id).status }.from('locked').to('unlocked')
      end
    end

    context '他人のブックマークへのリクエストの場合' do
      let(:user) { create(:user) }
      let(:another_user) { create(:another_user) }
      let(:achievement) { create(:achievement) }
      let(:bookmark) { create(:bookmark, user: user, achievement: achievement) }
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

      it '実績が解除されない' do
        expect do
          patch user_bookmark_url(another_user, bookmark)
        end.to_not change(Bookmark.find(bookmark.id), :status)
      end

      it 'リダイレクトする' do
        patch user_bookmark_url(another_user, bookmark)
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'DELETE #destroy' do
    context '自分のブックマークへのリクエストの場合' do
      let(:user) { create(:user) }
      let(:achievement) { create(:achievement) }
      let!(:bookmark) { create(:bookmark, user: user, achievement: achievement) }
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

      it 'リクエストが成功する' do
        delete user_bookmark_url(user, bookmark)
        expect(response.status).to eq 302
      end

      it 'ブックマークが削除される' do
        expect do
          delete user_bookmark_url(user, bookmark)
        end.to change(Bookmark, :count).by(-1)
      end

      it 'リダイレクトする' do
        delete user_bookmark_url(user, bookmark)
        expect(response).to redirect_to edit_user_url(user)
      end
    end

    context '他人のブックマークへのリクエストの場合' do
      let(:user) { create(:user) }
      let(:another_user) { create(:another_user) }
      let(:achievement) { create(:achievement) }
      let!(:bookmark) { create(:bookmark, user: user, achievement: achievement) }
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

      it 'ブックマークが削除されない' do
        expect do
          delete user_bookmark_url(another_user, bookmark)
        end.to_not change(Bookmark, :count)
      end

      it 'リダイレクトする' do
        delete user_bookmark_url(another_user, bookmark)
        expect(response).to redirect_to root_url
      end
    end
  end
end
