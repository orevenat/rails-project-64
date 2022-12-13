# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_or_guest_user

  def current_or_guest_user
    current_user || guest_user
  end

  def guest_user
    Guest.new
  end
end
