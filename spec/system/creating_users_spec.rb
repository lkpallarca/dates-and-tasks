require 'rails_helper'

RSpec.describe 'CreatingUsers', type: :system do
  before do
    driven_by(:rack_test)

    visit root_path
    find('a[href="/users/sign_up"]').click

    fill_in 'Email', with: 'kennced@kennced.com'
    fill_in 'Password', with: 'kennced'
    fill_in 'Password confirmation', with: 'kennced'
    find('input[type="submit"]').click
    visit calendar_path
  end

  let(:user) do
    User.find_by(email: 'kennced@kennced.com')
  end

  it 'creates user' do
    expect(user).to_not eq nil
  end
end