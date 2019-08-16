# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserStory, type: :model do
  context 'when valid user story' do
    it 'is valid user story' do
      expect(create(:user_story)).to be_valid
    end
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:release_id) }
  end
end
