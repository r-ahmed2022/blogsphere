require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(name: 'Riyaz', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from India', postscounter: 1) }

  it 'should have a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'should have a posts counter' do
    user.postscounter = nil
    expect(user).to_not be_valid
  end

  it 'posts counter should be integer' do
    user.postscounter = 'a'
    expect(user).to_not be_valid
  end

  it 'posts counter should be greater than or equal to 0' do
    user.postscounter = -1
    expect(user).to_not be_valid
  end
end
