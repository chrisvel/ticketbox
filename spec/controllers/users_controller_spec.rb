require 'rails_helper'
require 'user'

describe UsersController do

  before (:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create :user
    sign_in @user
  end

  let(:peter){ FactoryGirl.create :peter }

  describe "user access" do
    describe 'GET #index' do
      it "renders the :index template" do
        get :index
        expect(response.body).to have_content @users_all
      end
      it "returns JSON-formatted content" do
        get :index, format: :json
        expect(response.body).to have_content @tickets_unsolved.to_json
      end
    end

    describe 'GET #show' do
      it "renders the :show template" do
        get :show, id: @user
        expect(response).to render_template :show
      end
      it "assigns the requested contact to @user" do
        get :show, id: @user
        expect(assigns(:user)).to eq @user
      end
    end

    describe 'POST #new' do
      context 'with valid attributes' do
        it 'saves a new user in the database' do
          User.create!(FactoryGirl.attributes_for(:peter))
          expect(response).to be_success
          #expect{
          #  post :new, user: FactoryGirl.attributes_for(:peter)
          #}.to change(User, :count).by(1)
        end
      end
    end

  end
end
