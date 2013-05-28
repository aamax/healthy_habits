require 'spec_helper'

describe ContactsController do

  # This should return the minimal set of attributes required to create a valid
  # Contact. As you add validations to Contact, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "index" do
    context "not signed in" do
      it "should not allow access to the index action" do
        get :index
        response.should be_redirect

        flash.alert.should == "You are not authorized to access this page."
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

      it "should make sure all the contacts are in the index"
    end
  end

  it "should cover show action"
  it "should cover edit action"
  it "should cover update action"
  it "should cover new action"
  it "should cover create actions"
  it "should cover delete action"
  it "should validate email address format"
  it "should validate fname and lname are required"


  describe "GET show" do
    # if not signed in as admin - no access

    # allow access if admin user

    #it "assigns the requested contact as @contact" do
    #  contact = Contact.create! valid_attributes
    #  get :show, {:id => contact.to_param}, valid_session
    #  assigns(:contact).should eq(contact)
    #end
  end

  #describe "GET new" do
  #  it "assigns a new contact as @contact" do
  #    get :new, {}, valid_session
  #    assigns(:contact).should be_a_new(Contact)
  #  end
  #end
  #
  #describe "GET edit" do
  #  it "assigns the requested contact as @contact" do
  #    contact = Contact.create! valid_attributes
  #    get :edit, {:id => contact.to_param}, valid_session
  #    assigns(:contact).should eq(contact)
  #  end
  #end

  #describe "POST create" do
  #  describe "with valid params" do
  #    it "creates a new Contact" do
  #      expect {
  #        post :create, {:contact => valid_attributes}, valid_session
  #      }.to change(Contact, :count).by(1)
  #    end
  #
  #    it "assigns a newly created contact as @contact" do
  #      post :create, {:contact => valid_attributes}, valid_session
  #      assigns(:contact).should be_a(Contact)
  #      assigns(:contact).should be_persisted
  #    end
  #
  #    it "redirects to the created contact" do
  #      post :create, {:contact => valid_attributes}, valid_session
  #      response.should redirect_to(Contact.last)
  #    end
  #  end
  #
  #  describe "with invalid params" do
  #    it "assigns a newly created but unsaved contact as @contact" do
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Contact.any_instance.stub(:save).and_return(false)
  #      post :create, {:contact => { "name" => "invalid value" }}, valid_session
  #      assigns(:contact).should be_a_new(Contact)
  #    end
  #
  #    it "re-renders the 'new' template" do
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Contact.any_instance.stub(:save).and_return(false)
  #      post :create, {:contact => { "name" => "invalid value" }}, valid_session
  #      response.should render_template("new")
  #    end
  #  end
  #end
  #
  #describe "PUT update" do
  #  describe "with valid params" do
  #    it "updates the requested contact" do
  #      contact = Contact.create! valid_attributes
  #      # Assuming there are no other contacts in the database, this
  #      # specifies that the Contact created on the previous line
  #      # receives the :update_attributes message with whatever params are
  #      # submitted in the request.
  #      Contact.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
  #      put :update, {:id => contact.to_param, :contact => { "name" => "MyString" }}, valid_session
  #    end
  #
  #    it "assigns the requested contact as @contact" do
  #      contact = Contact.create! valid_attributes
  #      put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
  #      assigns(:contact).should eq(contact)
  #    end
  #
  #    it "redirects to the contact" do
  #      contact = Contact.create! valid_attributes
  #      put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
  #      response.should redirect_to(contact)
  #    end
  #  end
  #
  #  describe "with invalid params" do
  #    it "assigns the contact as @contact" do
  #      contact = Contact.create! valid_attributes
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Contact.any_instance.stub(:save).and_return(false)
  #      put :update, {:id => contact.to_param, :contact => { "name" => "invalid value" }}, valid_session
  #      assigns(:contact).should eq(contact)
  #    end
  #
  #    it "re-renders the 'edit' template" do
  #      contact = Contact.create! valid_attributes
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Contact.any_instance.stub(:save).and_return(false)
  #      put :update, {:id => contact.to_param, :contact => { "name" => "invalid value" }}, valid_session
  #      response.should render_template("edit")
  #    end
  #  end
  #end
  #
  #describe "DELETE destroy" do
  #  it "destroys the requested contact" do
  #    contact = Contact.create! valid_attributes
  #    expect {
  #      delete :destroy, {:id => contact.to_param}, valid_session
  #    }.to change(Contact, :count).by(-1)
  #  end
  #
  #  it "redirects to the contacts list" do
  #    contact = Contact.create! valid_attributes
  #    delete :destroy, {:id => contact.to_param}, valid_session
  #    response.should redirect_to(contacts_url)
  #  end
  #end

end
