class AdminsController < ApplicationController
  authorize_resource :class => User
  skip_authorize_resource :only => [:new,:create]
  # before_filter :authenticate_user!

  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = User.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = User.new
  end

  # GET /admins/1/edit
  def edit
  end

  

  # POST /admins
  # POST /admins.json
  def create
    @admin = User.find_by(username: admin_params[:signin])
    if @admin && @admin.valid_password?(admin_params[:password]) && @admin.roles == 'admin'
      sign_in @admin
      redirect_to admins_path
    else
      @admin = User.new
      render 'new'
    end
    # respond_to do |format|
    #   if @admin.save
    #     format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
    #     format.json { render :show, status: :created, location: @admin }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @admin.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params[:user]
    end

    def login_url
      admin_sign_in_path
    end
end
