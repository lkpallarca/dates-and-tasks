require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create(email: 'kennced@kennced.com',
                password: 'kennced')
  end

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    target_date: Date.current,
                    user_id: user.id)
  end

  subject do
    described_class.new(title: 'Task title',
                        body: 'Task body',
                        status: false,
                        category_id: category.id)
  end

  before do
    user
    category
  end

  context 'with associations' do
    it 'belongs to a category' do
      expect(described_class.reflect_on_association(:category).macro).to eq :belongs_to
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without body' do
    before do
      subject.body = nil
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when title is not unique' do
    before do
      described_class.create(
        title: subject.title,
        body: 'Sample body',
        status: false,
        category_id: subject.category_id
      )

      subject.title = subject.title
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when title contains integers and special characters' do
    before do
      described_class.create(title: subject.title,
                      body: subject.body,
                      status: false,
                      category_id: subject.category_id)

      subject.title = '69420@!'
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when title is longer than 25 characters' do
    before do
      subject.title = 'A' * 26
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end
end