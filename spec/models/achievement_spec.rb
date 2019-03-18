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
end
