class Admin::CardsController < ApplicationController

  before_action :set_board

  before_action :set_card, :only => [:edit, :update, :destroy]

  before_action :require_admin, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @card = Card.new
  end

  def create

    @card = Card.new(params.require(:card).permit(:title, :list_id, :due_date, :description, :progress))
    if @card.save
      flash[:success] = 'Successfully created card!'
      redirect_to admin_board_path(@board)
    else
      flash[:error] = 'Failed to created card!'
      redirect_to admin_board_path(@board)
    end

  end

  def edit
  end

  def update
    if @card.update(params.require(:card).permit(:title, :list_id, :due_date, :description, :progress))
      flash[:success] = 'Successfully updated card!'
      redirect_to admin_board_path(@board)
    end
  end

  def destroy
    @card.destroy
    flash[:success] = 'Successfully deleted card!'
    redirect_to admin_board_path(@board)
  end

  private
    def set_board
      @board = Board.find(params[:board_id])
      redirect_to boards_path unless (!@board.nil?)
    end

    def set_card
      @card = Card.find(params[:id])
      redirect_to admin_board_path(@board) unless (!@card.nil?)
    end

    def require_admin
      if (@card = Card.find_by(params[:id]))
        redirect_to admin_board_path(@board) unless ((@card.list.board_id == @board.id) && (current_user.is_admin?(@board)))
      else
        redirect_to admin_board_path(@board) unless (current_user.is_admin?(@board))
      end
    end
end
