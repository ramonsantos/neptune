# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AcceptTest, type: :model do
  context 'when valid accept test' do
    it 'is valid user accept test' do
      expect(create(:accept_test)).to be_valid
    end
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:user_story_id) }
  end
end
