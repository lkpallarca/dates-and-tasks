require 'rails_helper'

RSpec.describe 'EditingTasks', type: :system do
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

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    target_date: today,
                    user_id: user.id)
  end

  let(:attributes) do
    {
      title: 'Task title',
      body: 'Task body',
      status: false,
      category_id: category.id,
      user_id: user.id
    }
  end

  let(:updated_attributes) do
    {
      title: 'Task title Edited',
      body: 'Task body Edited',
    }
  end

  let(:task) do
    Task.create(attributes)
  end

  before do
    driven_by(:rack_test)

    sign_in user
    category

    visit calendar_path
    target_day.click

    task #create task first before coming in category show page to avoid page reload to show task element
    find("a[href='/categories/#{category.id}']", class: "link1").click
    find("a[href='/categories/#{category.id}/tasks/#{task.id}/edit']").click

    fill_in 'Title', with: 'Task title Edited'
    fill_in 'Body', with: 'Task body Edited'
    find('input[type="submit"]').click
  end

  it 'updates task' do
    expect(Task.find_by(attributes)).to eq nil
  end

  it 'correctly creates the updated task' do
    expect(Task.find_by(updated_attributes)).to_not eq nil
  end
end