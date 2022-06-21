require 'rails_helper'

RSpec.describe 'DeletingCategories', type: :system do
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
      title: 'Category Title',
      details: 'Category Details',
      target_date: today,
      user_id: user.id
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

    find("a[href='/categories/#{category.id}?target_day=#{today}']", class: "link3").click
  end

  it 'deletes category' do
    expect(Category.find_by(attributes)).to eq nil
  end
end