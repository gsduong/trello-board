class Admin::ListsController < ApplicationController

  before_action :set_board

  before_action :set_list, :only => [:edit, :update, :destroy]

  before_action :require_admin, :only => [:new, :create, :edit, :update, :destroy]

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
    @list = List.find(params[:id])
  end

  def update
    if @list.update(params.require(:list).permit(:title))
      flash[:success] = 'Successfully updated list!'
      redirect_to admin_board_path(@board)
    end
  end

  def destroy
    @list.destroy
    redirect_to admin_board_path(@board)
  end

  private
    def set_board
      @board = Board.find(params[:board_id])
      redirect_to boards_path unless (!@board.nil?)
    end

    def set_list
      @list = List.find(params[:id])
      redirect_to admin_board_path(@board) unless (!@list.nil?)
    end

    def require_admin
      if (@list = List.find_by(params[:id]))
        redirect_to admin_board_path(@board) unless ((@list.board_id == @board.id) && (current_user.is_admin?(@board)))
      else
        redirect_to admin_board_path(@board) unless (current_user.is_admin?(@board))
      end
    end
end
