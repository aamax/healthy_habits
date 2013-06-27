class ContactsController < ApplicationController
  require "json"

  respond_to :json, :html
  load_and_authorize_resource

  def create
    @contact = Contact.find_by_email(params[:email])
    @contact ||= Contact.new(fname: params[:fname], lname: params[:lname], email: params[:email])
    groups = {ezine: params[:ezine_list],
              microscopy: params[:microscopy_list],
              cleanse: params[:cleanse_list],
              coaching: params[:coaching_list],
              products: params[:products_list],
              events: params[:events_list]
              }

    @contact.meta_data = groups

    list_name = "Healthy Habits Utah Contacts"
    lists = Gibbon.lists({:filters => {:list_name => list_name}})
    list = lists["data"][0]

    groupings = Gibbon.listInterestGroupings(list)[0]

    group_str = ""
    if groups[:microscopy] == true
      group_str = add_string(group_str, "Microscopy")
    end
    if groups[:cleanse] == true
      group_str = add_string(group_str, "Cleanses")
    end
    if groups[:coaching] == true
      group_str = add_string(group_str, "Coaching")
    end
    if groups[:ezine] == true
      group_str = add_string(group_str, "eZine")
    end
    if groups[:products] == true
      group_str = add_string(group_str, "Products")
    end
    if groups[:events] == true
      group_str = add_string(group_str, "Events")
    end

    new_contact = {:id => list["id"],
                   :email_address => @contact.email,
                   :update_existing => true,
                   :double_optin => true,
                   :send_welcome => true,
                   :merge_vars => {
                                    'FNAME' => "#{@contact.fname}",
                                    'LNAME' => "#{@contact.lname}",
                                    'GROUPINGS' => {
                                        0 => {
                                              'id' => groupings["id"],
                                              'groups' => group_str
                                        }
                                    }
                                  }
                  }
    x = Gibbon.list_subscribe(new_contact)

    result = @contact.save
    respond_with @contact
  end

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
  def add_string(str, key)
    if str != ""
      str += ",#{key}"
    else
      str += key
    end
    str
  end
end
