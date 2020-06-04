class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?


	def after_sign_in_path_for(resource)  # ログイン後に遷移するpathを設定
        flash[:notice] = "successfully"
		user_path(current_user.id)		# マイページに遷移するよう指示
	end

	def after_sign_out_path_for(resource)  # ログアウト後に遷移するpathを設定
        flash[:notice] = "Signed out successfully."
		top_path	# topに戻るよう指示
	end

	def after_sign_up_path_for(resource)  # サインアップ後に遷移するpathを設定
        flash[:notice] = "successfully"
		user_path(current_user.id)
	end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
