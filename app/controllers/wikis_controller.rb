class WikisController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :is_admin, only: [:destroy]

  def index
    if user_signed_in? && current_user.subscribed
       @wikis=Wiki.visible_to_premium(current_user)
    else
       @wikis=Wiki.visible_to_standard
    end
  end


  def show
    @wiki=Wiki.find(params[:id])
  end


  def new
    @wiki=Wiki.new
  end


  def create
    @wiki = current_user.wikis.new(wiki_params)

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
     @wiki.assign_attributes(wiki_params)
     @wiki.user=current_user

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

  def wikis_after_user_unsubscribe(user)
    user.wikis.update_all(private: false)
  end

private

  def is_admin
    unless current_user.admin?
        redirect_to wikis_path, :flash => { :error => "You must be an admin to do that" }
    end
  end

  def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
  end

end
