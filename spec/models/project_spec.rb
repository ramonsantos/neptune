# frozen_string_literal: true

require 'rails_helper'

describe Project, type: :model do
  context 'when valid project' do
    it 'is valid with name' do
      expect(create(:project)).to be_valid
    end

    it 'is valid with name, start_date, and description' do
      expect(create(:project, description: nil, start_date: nil)).to be_valid
    end
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
