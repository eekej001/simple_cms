class AdminUsersController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @admin_users = AdminUser.sorted
  end 


  def new
    @admin_user = AdminUser.new
  end

  def create
    # Instantiate a new object using form parameters
    @admin_user = AdminUser.new(admin_user_params)
    # Save the object
    if @admin_user.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Admin user created successfully."
      redirect_to(:action => 'index')
    else  
      # If save fails, redisplay the form so the user can fix problems
      render('new')
    end  
  end  

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    # Find an existing object using form parameters
    @admin_user = AdminUser.find(params[:id])
    # Update the object
    if @admin_user.update_attributes(admin_user_params)
      # If save succeeds, redirect to the index action
      flash[:notice] = "Admin user updated successfully."
      redirect_to(:action => 'index')
    else  
      # If update fails, redisplay the form so the user can fix problems
      render('edit')
    end  
  end  


  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    admin_user = AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin user '#{admin_user.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  private 

    def admin_user_params
      params.require(:admin_user).permit(:first_name, :last_name, :username, :email, :password) 
    end

end
