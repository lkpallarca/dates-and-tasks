require 'rails_helper'

RSpec.describe 'CreatingTasks', type: :system do
  let(:user) do
    User.create(email: 'kennced@kennced.com',
                password: 'kennced')
  end

  let(:today) do
    Date.current
  end

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    target_date: today,
                    user_id: user.id)
  end

  let(:task) do
    Task.find_by(title: "Task title", body: "Task body")
  end

  let(:create_task_trigger) do
    find_by_id("create_task")
  end

  before do
    driven_by(:rack_test)

    sign_in user
    category

    visit category_path(category)
    create_task_trigger.click

    fill_in 'task[title]', with: 'Task title'
    fill_in 'task[body]', with: 'Task body'
    find('input[type="submit"]').click
  end

  it 'creates a task' do
    expect(task).to_not eq nil
  end
end