require 'rails_helper'

describe Achievement do
  describe 'validation' do
    subject { achievement }

    context 'すべて妥当なパラメータの場合' do
      let(:achievement) { build(:achievement) }

      it '有効' do
        achievement.tag_list = '1, 2, 3, 4, 5'
        achievement.save
        is_expected.to be_valid
      end
    end

    context 'タイトルが空の場合' do
      let(:achievement) { build(:achievement, title: '') }

      it '無効' do
        is_expected.to be_invalid
      end
    end

    context 'タイトルが重複している場合' do
      let!(:duplicated_achievement) { create(:achievement) }
      let(:achievement) { build(:achievement) }

      it '無効' do
        is_expected.to be_invalid
      end
    end

    context 'タイトルが長すぎる場合' do
      let(:achievement) { build(:achievement, title: 'a' * 101) }

      it '無効' do
        is_expected.to be_invalid
      end
    end

    context 'タグが多すぎる場合' do
      let(:achievement) { build(:achievement) }

      it '有効' do
        achievement.tag_list = '1, 2, 3, 4, 5, 6'
        achievement.save
        is_expected.to be_invalid
      end
    end
  end

  describe 'Achievement#unlocked_users' do
    context '解除したユーザがいない場合' do
      let(:user) { create(:user) }
      let(:achievement) { create(:achievement) }
      let!(:bookmark) { create(:bookmark, user: user, achievement: achievement) }

      it '空の配列を返す' do
        expect(achievement.unlocked_users).to eq []
      end
    end

    context '解除したユーザがいる場合' do
      let(:user1) { create(:user) }
      let(:user2) { create(:another_user) }
      let(:achievement) { create(:achievement) }
      let!(:bookmark1) { create(:bookmark, user: user1, achievement: achievement, status: :unlocked) }
      let!(:bookmark2) { create(:bookmark, user: user2, achievement: achievement, status: :unlocked) }

      it '解除したユーザたちを要素とする配列を返す' do
        expect(achievement.unlocked_users).to eq [user1, user2]
      end
    end
  end
end
