class ContactsController < ApplicationController
  require "json"

  respond_to :json, :html
  load_and_authorize_resource

  # GET /contacts
  # GET /contacts.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  #def new
  #  @contact = Contact.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @contact }
  #  end
  #end

  # GET /contacts/1/edit
  def edit

  end

  # POST /contacts
  # POST /contacts.json
  def create
    contact = Contact.new(params[:contact])
    if contact.save
      list_name = 'Healthy Habits Utah Contacts'
      list = Gibbon.lists({:filters => {:list_name => list_name}})["data"][0]

      # add contact to system
      x = Gibbon.list_subscribe({:id => list["id"],
                             :email_address => contact.email,
                             :update_existing => true,
                             :double_optin => true,
                             :send_welcome => true,
                             :merge_vars => {'FNAME' => "#{contact.fname}",'LNAME' => "#{contact.lname}", 'Group' => list_name,
                                             'eZine' => 'yes', 'Notify' => 'yes'
                             }})
      if x == true

        redirect_to root_path, :notice => "Thank you for registering!.  You'll recieve a confirmation email soon."
      else
        redirect_to root_path, :alert => "Error creating contact record. #{x.inspect}"
      end
    else
      redirect_to root_path, :alert => "Error creating contact record: <br/>FName: #{contact.fname}<br/>LName: #{contact.lname}<br/>Email: #{contact.email}".html_safe
    end

    #
    #@contact = Contact.new(params[:contact])
    #if (@contact.name == "name") && (@contact.email == "email")
    #  redirect_to :back, :notice=>"no entry added when name and email not enterred "
    #  return
    #end
    #
    #respond_to do |format|
    #  if @contact.save
    #    format.html { redirect_to root_path, notice: 'Contact was successfully created.' }
    #    format.json { render json: root_path, status: :created, location: @contact }
    #  else
    #    format.html { render action: :back, :alert=>"Error saving contact info" }
    #    format.json { render json: @contact.errors, status: "error saving contact info" }
    #  end
    #end
  end


  def cleanse_notice
    # if contact already exists then edit, otherwise create
    contact = Contact.find_by_email(params[:contact][:email])
    contact ||= Contact.new(params[:contact])
    if !contact.save
        redirect_to root_path,
                    :alert => "Error creating contact record: <br/>FName: #{contact.fname}<br/>LName: #{contact.lname}<br/>Email: #{contact.email}".html_safe
    end

    x = register_for_cleanse_notice contact
    if x == true
      redirect_to root_path, :notice => "Thank you for registering!.  You'll recieve a confirmation email soon."
    else
      redirect_to root_path, :alert => "Error creating contact record. #{x.inspect}"
    end
  end

  def register_for_cleanse_notice contact
    list_name = 'Healthy Habits Utah Cleanse Notice'
    list = Gibbon.lists({:filters => {:list_name => list_name}})["data"][0]

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

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.  NOT reflected in Mail Chimp!!!!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "Contact deleted.  NOT reflected in Mail Chimp!!!!!" }
      format.json { head :no_content }
    end
  end
end
