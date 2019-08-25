# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Release, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_many(:user_stories).dependent(:delete_all) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:project_id) }
  end

  context 'when valid release' do
    it 'is valid with name' do
      expect(create(:release)).to be_valid
    end

    it 'is valid with all attributes' do
      expect(create(:release_default)).to be_valid
    end
  end
end
