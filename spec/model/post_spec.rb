require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { Post.create(title: 'Test post', commentscounter: 1, likescounter: 20) }

  it 'should have a title' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'should have a valid length of title' do
    post.title = 'a' * 255
    expect(post).to_not be_valid
  end

  it 'comments counter should be integer' do
    post.commentscounter = 'a'
    expect(post).to_not be_valid
  end

  it 'should have a comments counter' do
    post.commentscounter = nil
    expect(post).to_not be_valid
  end

  it 'comments counter should be greater than or equal to 0' do
    post.commentscounter = -1
    expect(post).to_not be_valid
  end

  it 'should have a likes counter' do
    post.likescounter = nil
    expect(post).to_not be_valid
  end

  it 'likes counter should be integer' do
    post.likescounter = 'a'
    expect(post).to_not be_valid
  end

  it 'likes counter should be greater than or equal to 0' do
    post.likescounter = -1
    expect(post).to_not be_valid
  end
end
