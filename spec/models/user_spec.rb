require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.create(email: 'kennced@kennced.com',
                           password: 'kennced')
  end

  context 'with associations' do
    it 'has many categories' do
      expect(User.reflect_on_association(:categories).macro).to eq :has_many
    end

    it 'has many tasks' do
      expect(User.reflect_on_association(:tasks).macro).to eq :has_many
    end
  end

  context 'with dependents' do
    let(:category) do
      Category.create(title: 'Category Title',
                      details: 'Category Details',
                      target_date: Date.current,
                      user_id: subject.id)
    end

    let(:task) do
      Task.create(title: 'Category Title',
                      body: 'Category body',
                      category_id: category.id,
                      user_id: subject.id)
    end
    
    it 'deletes its categories' do
      category
      subject.destroy
      expect(Category.find_by(user_id: subject.id)).to eq nil
    end

    it 'deletes its tasks' do
      category
      task
      subject.destroy
      expect(Task.find_by(user_id: subject.id)).to eq nil
    end
  end
end