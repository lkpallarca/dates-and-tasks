require 'rails_helper'

RSpec.describe 'CreatingCategories', type: :system do
  let(:user) do
    User.create(email: 'kennced@kennced.com',
                password: 'kennced')
  end

  let(:category) do
    Category.find_by(title: 'Category Title',
                     details: 'Category Details')
  end

  let(:target_day) do
    find_link("#{Date.current}")
  end

  before do
    driven_by(:rack_test)

    sign_in user
    visit calendar_path
    target_day.click

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    find('input[type="submit"]').click
  end

  it 'creates category' do
    expect(category).to_not eq nil
  end
end