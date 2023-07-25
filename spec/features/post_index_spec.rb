require 'rails_helper'
describe 'Post index page', type: :feature do
  before :each do
    @user = User.create(name: 'Ajaz', photo: 'ajaz.jpg', bio: 'Manager')
    @post1 = Post.create(author: @user, title: 'Devise', text: 'for authentication')
    @post2 = Post.create(author: @user, title: 'integration tests', text: 'Testing views of the rails application')
    @post3 = Post.create(author: @user, title: 'unit test', text: 'for individual functions')
    @post4 = Post.create(author: @user, title: 'Devise1', text: 'for authentication -1')
    @post5 = Post.create(author: @user, title: 'Hello', text: 'for authentication -2')
    @comment1 = Comment.create(post: @post1, author: @user, text: 'great achievment')
    @comment2 = Comment.create(post: @post2, author: @user, text: 'little complicated than unit testing')
    visit user_posts_path(@user)
  end

  it 'shows the user profile picture' do
    expect(page).to have_css("img[src='#{@user.photo}']")
  end

  it 'shows the username of the user' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts for the user' do
    expect(page).to have_content(@user.postscounter)
  end

  it 'shows the title of posts' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post4.title)
  end

  it 'shows some of the posts text' do
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@post3.text)
  end

  it 'shows the first comments of a post' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end

  it 'shows the number of comments and likes for each post' do
    expect(page).to have_content(@post1.commentscounter)
    expect(page).to have_content(@post4.commentscounter)
    expect(page).to have_content(@post2.likescounter)
    expect(page).to have_content(@post3.likescounter)
  end

  it 'redirects to post show page of a clicked post' do
    click_link(@post1.title)
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end

  it 'redirects to post show page of a clicked post' do
    click_link(@post2.title)
    expect(page).to have_current_path(user_post_path(@user, @post2))
  end

  context 'when there are more than 5 posts' do
    before :each do
      @post6 = Post.create(author: @user, title: 'Ruby', text: 'little weird syntax')
      visit user_posts_path(@user)
    end
  end
end
