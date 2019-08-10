# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Release, type: :model do
  context 'when valid release' do
    it 'is valid with name' do
      expect(create(:release)).to be_valid
    end

    it 'is valid with all attributes' do
      expect(create(:release_default)).to be_valid
    end
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:project_id) }
  end
end
