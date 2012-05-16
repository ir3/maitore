class MembersController < ApplicationController
  def index
    @users = User.all
    @deleted_users = User.only_deleted
  end
end
