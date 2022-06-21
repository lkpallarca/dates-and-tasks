require 'rails_helper'

RSpec.describe 'EditingCategories', type: :system do
  let(:user) do
    User.create(email: 'kennced@kennced.com',
                password: 'kennced')
  end

  let(:today) do
    Date.current
  end

  let(:target_day) do
    find("a[href='/categories.#{category.id}?target_day=#{today}']")
  end

  let(:attributes) do
    {
      title: 'Category title',
      details: 'Category details',
      target_date: today,
      user_id: user.id
    }
  end

  let(:updated_attributes) do
    {
      title: 'Category title Edited',
      details: 'Category details Edited'
    }
  end

  let(:category) do
    Category.create(attributes)
  end

  before do
    driven_by(:rack_test)

    sign_in user
    category

    visit calendar_path
    target_day.click
    find("a[href='/categories/#{category.id}/edit?target_day=#{today}']").click

    fill_in 'Title', with: 'Category title Edited'
    fill_in 'Details', with: 'Category details Edited'
    find('input[type="submit"]').click
  end

  it 'updates category' do
    expect(Category.find_by(attributes)).to eq nil
  end

  it 'correctly creates the updated category' do
    expect(Category.find_by(updated_attributes)).to_not eq nil
  end
end