class Admin::CardsController < ApplicationController

  before_action :set_board

  def new
    @card = Card.new
  end

  def create

    redirect_to admin_board_path(@board) unless (current_user.is_admin?(@board))

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
    @card = Card.find(params[:id])
  end

  def update

    @card = Card.find(params[:id])

    redirect_to admin_board_path(@board) unless (!(@card.nil?))

    redirect_to admin_board_path(@board) unless ((@card.list.board_id == @board.id) && (current_user.is_admin?(@board)))

    if @card.update(params.require(:card).permit(:title, :list_id, :due_date, :description, :progress))
      flash[:success] = 'Successfully updated card!'
      redirect_to admin_board_path(@board)
    end
  end

  def destroy
    @card = Card.find(params[:id])
    redirect_to admin_board_path(@board) unless ((@card.list.board_id == @board.id) && (current_user.is_admin?(@board)))
    @card.destroy
    flash[:success] = 'Successfully deleted card!'
    redirect_to admin_board_path(@board)
  end

  private
    def set_board
      @board = Board.find(params[:board_id])
      redirect_to boards_path unless (!@board.nil?)
    end
end
