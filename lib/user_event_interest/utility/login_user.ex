defmodule UserEventInterest.Utility.LoginUser do

  def get_login_user_id(conn) do
    %{private: %{:plug_session => %{"user_id" => login_user_id}}} = conn
    login_user_id
  end
end
