describe UsersController, type: :request do
  describe 'GET #show' do
    context 'ユーザが存在する' do
      let(:user) { create(:user) }

      it 'リクエストが成功する' do
        get user_url(user.id)
        expect(response.status).to eq 200
      end

      it 'ユーザ名が表示される' do
        get user_url(user.id)
        expect(response.body).to include 'test_user'
      end
    end

    context 'ユーザが存在しない' do
      subject { -> { get user_url(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #edit' do
    context 'ユーザが存在する' do
      let(:user) { create(:user) }

      context '自分のページ' do
        before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

        it 'リクエストが成功する' do
          get edit_user_url(user.id)
          expect(response.status).to eq 200
        end

        it 'ユーザ名が表示される' do
          get edit_user_url(user.id)
          expect(response.body).to include 'test_user'
        end
      end

      context '他人のページ' do
        before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil) }

        it 'リダイレクトする' do
          get edit_user_url(user.id)
          expect(response).to redirect_to root_url
        end
      end
    end

    context 'ユーザが存在しない' do
      subject { -> { get edit_user_url(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
