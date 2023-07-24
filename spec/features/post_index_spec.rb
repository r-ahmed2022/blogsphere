require 'rails_helper'
RSpec.describe 'User index page', type: :feature do
  context 'when there are users' do
    before :each do
      @user1 = User.create(name: 'Riyaz Ali', photo: 'riyaz.jpg', bio: 'The developer',
                           postscounter: 0)
      @user2 = User.create(name: 'Basim', photo: 'basim.jpg', bio: 'SE',
                           postscounter: 0)
      @post1 = Post.create(author_id: @user1, title: 'Hello', text: 'This is a test post')
      @comment1 = Comment.create(author_id: @user2, post_id: @post1, text: 'this is comment1')
      @comment2 = Comment.create(author_id: @user2, post_id: @post1, text: 'this is comment2')
      @comment3 = Comment.create(author_id: @user2, post_id: @post1, text: 'this is comment3')
      @comment4 = Comment.create(author_id: @user2, post_id: @post1, text: 'this is comment4')
      @comment5 = Comment.create(author_id: @user2, post_id: @post1, text: 'this is comment5')
      visit user_posts_path(@user1, @post1)
    end

    it 'shows usernames of all other users' do
      expect(page).to have_content(@user1.name)
    end

    it 'shows the profile picture for each user' do
      expect(page).to have_css("img[src='#{@user1.photo}']")
    end

    it 'shows the number of posts for each user' do
      expect(page).to have_content(@user1.postscounter)
    end

    it 'shows the post title' do
      expect(page).to have_content(@post1.title)
    end

    it 'shows some of the post body' do
      expect(page).to have_content(@post1.text)
    end

    it 'shows the first comments on a post' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
      expect(page).to have_content(@comment4.text)
      expect(page).to have_content(@comment5.text)
    end

    it 'shows comments count' do
      expect(page).to have_content(@post1.commentscounter)
    end
    it 'shows likes count' do
      expect(page).to have_content(@post1.likescounter)
    end

    #   it "shows  section for pagination if there are more posts than fit on the view" do
    #     --------
    #   end
    it "redirects me to that post's show page" do
      click_link(@post1.title.to_s)
      expect(page).to have_current_path(user_post_path(@user1, post1))
    end
  end
end
