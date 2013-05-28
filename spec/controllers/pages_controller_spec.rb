require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PagesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "show" do
    context "not signed in" do
      context "static pages" do
        it "should show home page" do
          get :show, id: "home"
          response.should render_template "pages/partials/home"
        end

        it "should show 'is_this_you'" do
          get :show, id: "is_this_you"
          response.should render_template "pages/partials/is_this_you"
        end

        it "should show 'different'" do
          get :show, id: "different"
          response.should render_template "pages/partials/different"
        end

        it "should show 'meet_cathy'" do
          get :show, id: "meet_cathy"
          response.should render_template "pages/partials/meet_cathy"
        end

        it "should show 'microscopy'" do
          get :show, id: "microscopy"
          response.should render_template "pages/partials/microscopy"
        end

        it "should show 'construction'" do
          get :show, id: "construction"
          response.should render_template "pages/partials/construction"
        end

        it "should show a page from the database" do
          # set up page contents
          page = FactoryGirl.create(:page)
          page.save

          get :show, id: "saved_page"
          response.should be_success

          get :show, id: "no_page"
          response.should be_redirect
        end
      end
    end

    context "admin user signed in" do
      before :each do
        # sign in admin user
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin_user = FactoryGirl.create(:user, email: "test6@example.com")
        @admin_user.add_role :admin
        sign_in @admin_user
      end

      it "should show home page" do
        get :show, id: "home"
        response.should render_template "pages/partials/home"
      end

      it "should show 'is_this_you'" do
        get :show, id: "is_this_you"
        response.should render_template "pages/partials/is_this_you"
      end

      it "should show 'different'" do
        get :show, id: "different"
        response.should render_template "pages/partials/different"
      end

      it "should show 'meet_cathy'" do
        get :show, id: "meet_cathy"
        response.should render_template "pages/partials/meet_cathy"
      end

      it "should show 'microscopy'" do
        get :show, id: "microscopy"
        response.should render_template "pages/partials/microscopy"
      end

      it "should show 'construction'" do
        get :show, id: "construction"
        response.should render_template "pages/partials/construction"
      end

      it "should show a page from the database" do
        # set up page contents
        page = FactoryGirl.create(:page)
        page.save

        get :show, id: "saved_page"
        response.should be_success

        # show edit button
        response.should have_link('edit', href: edit_page_path(page))

        get :show, id: "no_page"
        response.should be_redirect
      end
    end
  end

  describe "index" do
    context "not signed in" do
      it "should not allow access to the index action" do
        get :index
        response.should be_redirect

        flash.alert.should == "You are not authorized to view this page"
      end
    end

    context "admin user signed in" do
      it "should allow access to the index action" do
        # sign in admin user
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin_user = FactoryGirl.create(:user, email: "test6@example.com")
        @admin_user.add_role :admin
        sign_in @admin_user

        get :index
        response.should be_success
      end
    end

  end

  describe "new" do
    context "not signed_in" do
      it "should not allow access to the new action" do
        get :new
        response.should be_redirect
        flash.alert.should == "You are not authorized to view this page"
      end
    end

    context "admin user signed in" do
      it "should allow access to the new action" do
        # sign in admin user
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin_user = FactoryGirl.create(:user, email: "test6@example.com")
        @admin_user.add_role :admin
        sign_in @admin_user

        get :new
        response.should be_success
      end
    end
  end

  describe "edit" do
    context "not signed_in" do
      it "should not allow access to the edit action" do
        page = FactoryGirl.create(:page)
        page.save

        get :edit, id: page.id
        response.should be_redirect
        flash.alert.should == "You are not authorized to view this page"
      end
    end

    context "admin user signed in" do
      it "should allow access to the edit action" do
        page = FactoryGirl.create(:page)
        page.save

        # sign in admin user
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin_user = FactoryGirl.create(:user, email: "test6@example.com")
        @admin_user.add_role :admin
        sign_in @admin_user

        get :edit, id: page.id
        response.should be_success
      end
    end

  end

  describe "destroy" do
    context "not signed_in" do
      it "should not allow access to the destroy action" do
        page = FactoryGirl.create(:page)
        page.save

        post :destroy, :id => page.id
        response.should be_redirect
        flash.alert.should == "You are not authorized to delete this page"
      end
    end

    context "admin user signed in" do
      it "should allow access to the destroy action" do
        page = FactoryGirl.create(:page)
        page.save

        # sign in admin user
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin_user = FactoryGirl.create(:user, email: "test6@example.com")
        @admin_user.add_role :admin
        sign_in @admin_user

        post :destroy, :id => page.id
        flash.notice.should == "This Page was destroyed."
      end
    end
  end

  describe "create" do
    context "not signed_in" do
      it "should not allow access to the create action" do
        page = Page.new(name: "page", title: "page", content: "page")

        post :create, :page => page
        response.should be_redirect
        flash.alert.should == "You are not authorized to create this page"
      end
    end

    context "admin user signed in" do
      it "should allow access to the create action" do
        page = FactoryGirl.create(:page)

        # sign in admin user
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin_user = FactoryGirl.create(:user, email: "test6@example.com")
        @admin_user.add_role :admin
        sign_in @admin_user

        post :create, page: {id: page.id, content: page.content, title: page.title }
        flash.notice.should == "Page created."
      end
    end
  end

  describe "update" do
    context "not signed_in" do
      it "should not allow access to the update action" do
        page = FactoryGirl.create(:page)
        page.save
        put :update, id: page.id, :page => page
        response.should be_redirect
        flash.alert.should == "You are not authorized to update this page"
      end
    end

    context "admin user signed in" do
      it "should allow access to the update action" do
        page = FactoryGirl.create(:page)
        page.save

        # sign in admin user
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin_user = FactoryGirl.create(:user, email: "test6@example.com")
        @admin_user.add_role :admin
        sign_in @admin_user

        put :update, id: page.id, page: {id: page.id, content: page.content, title: page.title }
        flash.notice.should == "Page Updated."
      end
    end

  end
end
