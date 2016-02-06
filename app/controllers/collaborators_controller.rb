class CollaboratorsController < ApplicationController

  before_action :set_wiki

  def index
    @users = User.all
  end

  def create
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "You added collaborator!"
    else
      flash[:error]="There was an error adding the collaborator. Please try again"
    end
    redirect_to :back
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "You removed a collaborator!"
    else
      flash[:error]="There was an error removing the collaborator. Please try again"
    end
    redirect_to :back
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

end
