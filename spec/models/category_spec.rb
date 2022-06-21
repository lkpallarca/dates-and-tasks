require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) do
    User.create(email: 'kennced@kennced.com',
                password: 'kennced')
  end

  subject do
    described_class.new(title: 'Category Title',
                        details: 'Category Details',
                        target_date: Date.current,
                        user_id: user.id)
  end

  before do
    user
  end

  context 'with associations' do
    it 'belongs to a user' do
      expect(Category.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'has many tasks' do
      expect(Category.reflect_on_association(:tasks).macro).to eq :has_many
    end
  end

  context 'with dependents' do
    let(:task) do
      Task.create(title: 'Task title',
                  body: 'Task body',
                  status: false,
                  category_id: subject.id)
    end

    before do
      subject.save
      task
      subject.destroy
    end

    it 'deletes its tasks' do
      expect(Task.find_by(category_id: subject.id)).to eq nil
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without a title' do
    before do
      subject.title = nil
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when title is not unique' do
    before do
      Category.create(title: subject.title,
                      details: subject.details,
                      target_date: Date.current,
                      user_id: subject.user_id)

      subject.title = subject.title
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when title contains integers and special characters' do
    before do
      Category.create(title: subject.title,
                      details: subject.details,
                      target_date: Date.current,
                      user_id: subject.user_id)

      subject.title = '69420@!'
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when title is longer than 25 characters' do
    before do
      subject.title = 'This is thirty characters'

      Category.create(title: subject.title,
                      details: subject.details,
                      target_date: Date.current,
                      user_id: subject.user_id)
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'without details' do
    before do
      subject.details = nil
    end

    it 'does validate' do
      expect(subject).to be_valid
    end
  end
end