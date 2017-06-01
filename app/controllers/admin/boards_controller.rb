class Admin::BoardsController < ApplicationController
  before_action :require_login
  before_action :require_admin, :only => [:show, :edit, :update, :destroy]


  # GET admin/boards/1
  def show
    @board = current_user.boards.find(params[:id])
    @members = @board.users
  end

  # GET admin/boards/1/edit
  def edit
    @board = current_user.boards.find(params[:id])
  end

  # PATCH/PUT /boards/1
  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      flash[:success] = 'Successfully updated board!'
      redirect_to boards_path
    else
      render 'edit'
    end
  end

  # DELETE /boards/1
  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy
    flash[:success] = 'Successfully deleted board!'
    redirect_to boards_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = current_user.boards.find_by(id: params[:id])
      redirect_to root_url unless (!@board.nil?)
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def board_params
    params.require(:board).permit(:name, :description)
  end

  # Filter
  def require_admin
    @board = current_user.boards.find(params[:id])
    unless current_user.is_admin?(@board)
      redirect_back(fallback_location: root_url)
    end
  end
end
