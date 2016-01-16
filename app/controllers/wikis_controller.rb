class WikisController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :is_admin, only: [:destroy]

  def index
    @wikis=Wiki.visible_to
  end


  def show
    @wiki=Wiki.find(params[:id])
  end


  def new
    @wiki=Wiki.new
  end


  def create
    @wiki=Wiki.new
    @wiki.title=params[:wiki][:title]
    @wiki.body=params[:wiki][:body]
    @wiki.user=current_user

    if @wiki.save
      flash[:notice] = "Your wiki is saved!"
      redirect_to wikis_path
    else
      flash[:error]="There was an error creating the wiki. Please try again"
      render :new
    end
  end

  def edit
     @wiki=Wiki.find(params[:id])
  end


  def update
     @wiki=Wiki.find(params[:id])
     @wiki.title=params[:wiki][:title]
     @wiki.body=params[:wiki][:body]

     if @wiki.save!
       flash[:notice]='Your wiki is updated'
       redirect_to wikis_path
     else
       flash[:error]='Somtehing is wrong, please try again'
       render :edit
     end
  end


  def destroy
     @wiki=Wiki.find(params[:id])

    if @wiki.destroy!
      flash[:notice]= 'The Wiki is dead now'
      redirect_to wikis_path
    else
      flash[:alert]= 'Please try again'
      render :edit
    end
  end

private

  def is_admin
    unless current_user.admin?
        redirect_to wikis_path, :flash => { :error => "You must be an admin to do that" }
    end
  end

end
