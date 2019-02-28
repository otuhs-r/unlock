require 'rails_helper'

describe Achievement do
  describe 'validation' do
    subject { achievement }

    context 'all valid params' do
      let(:achievement) { build(:achievement) }

      it 'is valid' do
        is_expected.to be_valid
      end
    end

    context 'empty title' do
      let(:achievement) { build(:achievement, title: '') }

      it 'is NOT valid' do
        is_expected.to be_invalid
      end
    end

    context 'duplicated title' do
      let!(:duplicated_achievement) { create(:achievement) }
      let(:achievement) { build(:achievement) }

      it 'is NOT valid' do
        is_expected.to be_invalid
      end
    end

    context 'too long title' do
      let(:achievement) { build(:achievement, title: 'a' * 101) }

      it 'is NOT valid' do
        is_expected.to be_invalid
      end
    end
  end
end
