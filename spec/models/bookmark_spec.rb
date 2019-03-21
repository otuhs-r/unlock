require 'rails_helper'

describe Achievement do
  describe 'validation' do
    subject { bookmark }

    context 'パラメータが正常な場合' do
      let(:bookmark) { build(:bookmark, user: create(:user), achievement: create(:achievement)) }

      it '有効' do
        is_expected.to be_valid
      end
    end

    context 'ユーザが空の場合' do
      let(:bookmark) { build(:bookmark, user: nil, achievement: create(:achievement)) }

      it '無効' do
        is_expected.to be_invalid
      end
    end

    context '実績が空の場合' do
      let(:bookmark) { build(:bookmark, user: create(:user), achievement: nil) }

      it '無効' do
        is_expected.to be_invalid
      end
    end

    context 'ブックマークが重複している場合' do
      let(:user) { create(:user) }
      let(:achievement) { create(:achievement) }
      let!(:duplicated_bookmark) { create(:bookmark, user: user, achievement: achievement) }
      let(:bookmark) { build(:bookmark, user: user, achievement: achievement) }

      it '無効' do
        is_expected.to be_invalid
      end
    end
  end

  describe 'work correctly' do
    describe 'Bookmark#reverse' do
      let(:bookmark) { build(:bookmark, user: create(:user), achievement: create(:achievement)) }

      it '解除から未解除になる' do
        expect(bookmark.reverse.unlocked?).to eq true
      end

      it '未解除から解除になる' do
        bookmark.unlocked!
        expect(bookmark.reverse.unlocked?).to eq false
      end
    end

    describe 'Bookmark#unlock_date' do
      let(:bookmark) { build(:bookmark, user: create(:user), achievement: create(:achievement), unlock_date: '2019-3-21') }

      it '解除されていなかったら nil を返す' do
        expect(bookmark.unlock_date).to eq nil
      end

      it '解除されていたら解除日を返す' do
        bookmark.unlocked!
        expect(I18n.l(bookmark.unlock_date)).to eq '2019/03/21'
      end
    end
  end
end
