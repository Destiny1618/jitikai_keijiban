class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    public_topics_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  def after_sign_up_path_for(resource)
    public_topics_path
  end

  private



end