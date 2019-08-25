# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserStory, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:release) }
    it { is_expected.to have_many(:accept_tests).dependent(:delete_all) }
    it { is_expected.to have_many(:tasks).dependent(:delete_all) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:release_id) }
    it { is_expected.to validate_presence_of(:situation) }
  end

  context 'when valid user story' do
    it 'is valid user story' do
      expect(create(:user_story)).to be_valid
    end
  end
end
