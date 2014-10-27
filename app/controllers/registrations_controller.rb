class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_office!

  def create
    build_resource(sign_up_params)
    resource.password = Devise.friendly_token.first(8)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      flash[:notice] = "User account successfully created." if is_flashing_format?
      UserMailer.welcome_email(resource, resource.password).deliver
      respond_with resource, location: admin_user_accounts_path
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  private

    def sign_up_params
      params.require(:office).permit(:name, :email)
    end

    def account_update_params
      params.require(:office).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
end
