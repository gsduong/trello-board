class Admin::ListsController < ApplicationController
  before_action :require_login
  before_action :set_board
  before_action :require_admin

  def new
    @list = @board.lists.new
  end

  def create
    list = @board.lists.new(params.require(:list).permit(:title))
    list.save
    flash[:success] = 'Success fully created list!'
    redirect_to admin_board_path(@board)
  end

  def edit
    @list = @board.lists.find(params[:id])
  end

  def update
    @list = @board.lists.find(params[:id])
    if @list.update(params.require(:list).permit(:title))
      flash[:success] = 'Successfully updated list!'
      redirect_to admin_board_path(@board)
    end
  end

  def destroy
    @list = @board.lists.find(params[:id])
    @list.destroy
    redirect_to admin_board_path(@board)
  end

  private
    def set_board
      @board = current_user.boards.find(params[:board_id])
      redirect_to boards_path unless (!@board.nil?)
    end

    def require_admin
      @board = current_user.boards.find(params[:board_id])
      redirect_to admin_board_path(@board) unless current_user.is_admin?(@board)
    end
end
