require 'rails_helper'
describe 'User show page', type: :feature do
  before :each do
    @user = User.create(name: 'Ali', photo: 'riyaz.jpg', bio: 'The developer', postscounter: 2)
    @post1 = Post.create(author: @user, title: 'last post', text: 'Yes, could be')
    @post2 = Post.create(author: @user, title: 'rails', text: 'Learning right now')
    @post3 = Post.create(author: @user, title: 'testing', text: 'testing it ')

    visit user_path(@user)
  end

  it 'shows user profile picture' do
    expect(page).to have_css("img[src='#{@user.photo}']")
  end

  it 'shows username of user' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the the number of posts a user has written' do
    expect(page).to have_content(@user.postscounter)
  end

  it 'shows the bio of user' do
    expect(page).to have_content(@user.bio)
  end

  it 'shows the first three posts of the user' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
  end

  it 'displays a button to see all posts' do
    expect(page).to have_link('See all posts')
  end

  it 'redirects to post show page of a clicked post' do
    click_link(@post1.title.to_s)
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end

  it 'redirects to post show page of a clicked post' do
    click_link(@post2.title.to_s)
    expect(page).to have_current_path(user_post_path(@user, @post2))
  end

  it 'redirects to post show page of a clicked post' do
    click_link(@post3.title.to_s)
    expect(page).to have_current_path(user_post_path(@user, @post3))
  end

  it 'redirects to the posts index page of the user when one clicks the see all posts button' do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
