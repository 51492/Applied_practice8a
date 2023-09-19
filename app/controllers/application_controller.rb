class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行される

  def after_sign_in_path_for(resource)
    books_path
  end
  # after_sign_in_path_forはDeviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定している。Deviseの初期設定ではroot_pathになっている。

  def after_sign_out_path_for(resource)
    root_path
  end
  # Deviseのデフォルトはaftere_sign_in_path_forと同様root_path

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.permitメソッドを使うことでユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可
  end

end
