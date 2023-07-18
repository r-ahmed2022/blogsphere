require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before(:each) do
    @user = User.create(name: 'Riyaz', photo: 'riyaz.jpg', bio: 'The developer', postscounter: 1)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get users_path
      expect(response).to be_successful
      expect(response.body).to include('users')
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns the user details' do
      expect(@user).to be_valid
      expect(@user.id).not_to be_nil
      get user_path(@user.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(@user.bio)
    end
  end
end
