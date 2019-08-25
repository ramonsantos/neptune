# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user_story) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user_story_id) }
  end

  context 'when valid task' do
    it 'is valid user task' do
      expect(create(:task)).to be_valid
    end
  end
end
