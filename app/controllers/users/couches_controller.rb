class Users::CouchesController < UsersController
  before_action :verify_user, only: [:new, :create]

  def new
    @user = User.find(params[:user_id])
    @couch = Couch.new
  end

  def create
    couch = current_user.couches.new(couch_params)
    if couch.save
      flash[:success] = "Couch Created!"
      redirect_to user_couch_path(current_user, couch)
    else
      flash[:danger] = couch.errors.full_messages.join(", ")
      redirect_to new_user_couch_path(current_user, couch)
    end
  end

  def show
    @couch = current_user.couches.find(params[:id])
    @nights = @couch.nights
  end

  private
    def couch_params
      params.require(:couch).permit(:name,
                                    :description,
                                    :street_address,
                                    :city,
                                    :state,
                                    :zipcode,
                                    :host)
    end

    def verify_user
      render file: "public/404", status: 404 unless current_user && current_user.id == params["user_id"].to_i
    end
end
