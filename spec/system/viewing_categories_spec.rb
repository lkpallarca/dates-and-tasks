require 'rails_helper'

RSpec.describe 'ViewingCategories', type: :system do
  let(:user) do
    User.create(email: 'kennced@kennced.com',
                password: 'kennced')
  end

  let(:today) do
    Date.current
  end

  before do
    driven_by(:rack_test)

    sign_in user
  end

  describe Category do
    subject do
      described_class.create(title: 'Category Title',
                             details: 'Category Details',
                             target_date: today,
                             user_id: user.id)
    end

    before do
      subject

      visit calendar_path
    end
  end
end