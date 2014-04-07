require 'spec_helper'

describe PostsController do

  context "when user not logged in" do
    describe "GET #index" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:post, user: user) }
        
    before do
      sign_in user
    end

    describe "GET #index" do
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns the requested post to subject" do
        get :index
        expect(assigns(:posts)).to eq([subject])
      end
    end

    describe "GET #show" do
      it "assigns the requested post to subject" do
        get :show, id: subject
        expect(assigns(:post)).to eq(subject)
      end

      it "renders the :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns the requested post to new post" do
        get :new
        expect(assigns(:post)).to be_new_record 
      end
      
      it "renders the :new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{
            post :create, post: FactoryGirl.attributes_for(:post)
          }.to change(Post, :count).by(1)
        end
      
        it "rendirects to index path" do
          post :create, post: FactoryGirl.attributes_for(:post)
          expect(response).to redirect_to posts_path
        end
      end
      
      context "with not valid attributes" do
        it "not save object to db" do
          expect{
            post :create, post: FactoryGirl.attributes_for(:invalid_post)
          }.to_not change(Post, :count)
        end
      
        it "render new view" do
          post :create, post: FactoryGirl.attributes_for(:invalid_post)
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{
            patch :update, id: subject, post: { title: 'new_post' }
          }.to change{ subject.reload.title }.to('new_post')
        end
      
        it "rendirects to index path" do
          patch :update, id: subject, post: { title: 'new_post' }
          expect(response).to redirect_to posts_path
        end
      end
      
      context "with not valid attributes" do
        it "not save object to db" do
          expect{
            patch :update, id: subject, post: FactoryGirl.attributes_for(:invalid_post)
          }.to_not change{ subject.title }
        end
      
        it "render edit view" do
          post :update, id: subject, post: FactoryGirl.attributes_for(:invalid_post)
          expect(response).to render_template :edit
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested post to subject" do
        get :edit, id: subject
        expect(assigns(:post)).to eq(subject)
      end
      
      it "renders the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end

    describe 'DELETE #destroy' do
      before(:each) { @post = FactoryGirl.create :post, user: user }

      it "deletes the post" do
        expect {
          delete :destroy, id: @post
        }.to change(Post, :count).by(-1)
      end

      it "redirects to posts#index" do
        delete :destroy, id: @post
        expect(response).to redirect_to posts_path
      end
    end
  end
end