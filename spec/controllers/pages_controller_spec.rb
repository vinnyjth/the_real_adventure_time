require 'spec_helper'

describe PagesController do
  describe "guest access" do

    describe "GET 'index'" do

      it "returns http success" do
        get :index
        expect(response).to render_template :index
      end

      it 'populates a list of pages' do
        page = create(:page)
        get :index
        expect(assigns(:pages)).to match_array [page]
      end

      it 'responds to search' do
        page = create(:page, title: "Turtles")
        get :index, term: "tur"
        expect(assigns(:pages)).to match_array [page]
      end
    end

    describe "Get 'show" do 

      before :each do 
        @page = create(:page)
      end

      it "shows a page" do
        get :show, id: @page.id
        expect(response).to render_template :show
      end

      it "shows a page" do
        get :show, id: @page.id
        expect(assigns(:page)).to eq @page
      end

    end

    describe "GET 'new'" do
      it 'should not allow guest to create a page' do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
