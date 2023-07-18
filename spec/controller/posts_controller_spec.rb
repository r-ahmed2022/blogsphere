require 'rails_helper'

#RSpec.describe 'Posts', type: :request do
#  before(:each) do
#    @user = User.create(name: 'Hamid Gul', photo: 'user-6.avif', bio: 'Web developer', postscounter: 1)
#    @post = Post.create(title: 'Bear Trap', text: 'Afghan struggle with Soviets', author: @user, commentscounter: 1, likescounter: 2)
#  end
#  describe 'posts#index' do
#     it 'index for post works!' do
#      get user_posts_path(@user)
#      expect(response).to have_http_status(200)
#      expect(response.body).to include('posts')
#      expect(response).to render_template(:index)
#    end
#  end
#
#  describe 'GET #show' do
#    it 'show for post works!' do
#      get users_path(@user, @post)
#      expect(response).to have_http_status(200)
#      expect(response.body).to include(@post.title)
#      expect(response.body).to include(@post.text)
#      expect(response).to render_template(:show)
#    end
#  end
#end
#
RSpec.describe 'Posts', type: :request do
  user = User.create(name: 'Riyaz', photo: 'user-6.avif', bio: 'Web developer', postscounter: 1)
  post = Post.create(title: 'Bear Trap', text: 'Afghan struggle with Soviets', author: user, commentscounter: 1, likescounter: 2)

  describe 'posts#index' do
    before do
      get user_posts_path(user)
    end

    it 'index for post works!' do
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('posts')
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before do
      get user_post_path(user, post)
    end

    it 'show for post works!' do
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(post.title)
      expect(response.body).to include(post.text)
      expect(response).to render_template(:show)
    end
  end
end