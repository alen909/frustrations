class FrustrationsController < ApplicationController

  before_filter :require_user, except: [:index, :show]
  before_filter :check_ownership, only: [:edit, :destroy, :update]

  def index
    @frustrations = Frustration.order("created_at DESC")
    @frustrations = Frustration.where('title LIKE ?', "%#{params[:q]}%").order('created_at DESC')
  end
  def show
    @frustration = Frustration.find(params[:id])
    @comment = @frustration.comments.build
  end

  def new
    @frustration = Frustration.new
  end
  def create
     @frustration = current_user.frustrations.build(frustration_params)
    if @frustration.save
      redirect_to frustrations_url,
        notice: "Frustration created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @frustration.update(frustration_params)
      redirect_to frustrations_url,
      notice: "Updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @frustration.destroy
    redirect_to frustrations_url,
      notice: "Deleted successfully"
  end

  private
  def check_ownership
    @frustration = Frustration.find(params[:id])
    if @frustration.user_id != current_user.id
      redirect_to frustrations_url,
      alert: "You can only edit or delete own frustrations"
    end
  end
  def frustration_params 
    params.require(:frustration).permit(:title, :body, :cover)
  end

end
