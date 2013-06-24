class ContactsController < ApplicationController
  require "json"

  respond_to :json, :html
  load_and_authorize_resource

  # GET /contacts
  # GET /contacts.json
  def index
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @contacts }
    #end
    redirect_to root_path, :alert => "You may not access this page"
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @contact }
    #end
    redirect_to root_path, :alert => "You may not access this page"
  end

  # GET /contacts/1/edit
  def edit
    redirect_to root_path, :alert => "You may not access this page"
  end

  # POST /contacts
  # POST /contacts.json


  def create
    # TODO
    # gonna need to iterate through the check boxes and sign up for the lists
    # the user is interested in (if any)
    # modify sign up so it doesn't send a confirm for each list etc

    #handle_contact_create 'Healthy Habits Utah Contacts'
    @contact = Contact.find_by_email(params[:email])
    @contact ||= Contact.new(fname: params[:fname], lname: params[:lname], email: params[:email])



    respond_with @contact
  end

  def cleanse_notice
    handle_contact_create 'Healthy Habits Utah Cleanse Notice'
  end
  
  def microscopy_notice
    handle_contact_create 'Microscopy Group'
  end
  

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    #respond_to do |format|
    #  if @contact.update_attributes(params[:contact])
    #    format.html { redirect_to @contact, notice: 'Contact was successfully updated.  NOT reflected in Mail Chimp!!!!' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @contact.errors, status: :unprocessable_entity }
    #  end
    #end
    redirect_to root_path, :alert => "You may not access this page"
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    #@contact.destroy
    #
    #respond_to do |format|
    #  format.html { redirect_to contacts_url, notice: "Contact deleted.  NOT reflected in Mail Chimp!!!!!" }
    #  format.json { head :no_content }
    #end
    redirect_to root_path, :alert => "You may not access this page"
  end

  private

  def handle_contact_create list_name
    # if contact already exists then edit, otherwise create
    contact = Contact.find_by_email(params[:contact][:email])
    if contact.nil?
      contact = Contact.new(params[:contact])
      v = contact.save
    else
      v = contact.update_attributes(params[:contact])
    end

    if !v
      redirect_to root_path,
                  :alert => "Error creating contact record: <br/>
                              FName: #{contact.fname}<br/>
                              LName: #{contact.lname}<br/>
                              Email: #{contact.email}".html_safe
      return
    end

    x = register_with_gibbon contact, list_name
    if x == true
      redirect_to root_path, :notice => "Thank you for registering!.  You'll recieve a confirmation email soon."
    else
      redirect_to root_path, :alert => "Error creating contact record. #{x.inspect}"
    end

  end


  def register_with_gibbon contact, list_name
  lists = Gibbon.lists({:filters => {:list_name => list_name}})
  list = lists["data"][0]

  # add contact to system
  x = Gibbon.list_subscribe({:id => list["id"],
                             :email_address => contact.email,
                             :update_existing => true,
                             :double_optin => true,
                             :send_welcome => true,
                             :merge_vars => {'FNAME' => "#{contact.fname}",'LNAME' => "#{contact.lname}", 'Group' => list_name,
                                             'eZine' => 'yes', 'Notify' => 'yes'
                             }})
  end

end
