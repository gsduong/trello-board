class CardsController < ApplicationController
  before_action :require_login
  before_action :set_board
  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def create
    redirect_to boards_path unless current_user.is_member?(@board)
    @card = Card.new(params.require(:card).permit(:title, :list_id, :due_date, :description, :progress ))
    if @card.save
      card_member = CardMember.new(card_id: @card.id, member_id: current_user.id)
      card_member.save
      flash[:success] = 'Successfully created card!'
      redirect_to board_path(@board)
    else
      flash[:error] = 'Failed to created card!'
      redirect_to board_path(@board)
    end
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(params.require(:card).permit(:title, :list_id, :due_date, :description, :progress ))
      flash[:success] = 'Successfully updated list!'
      redirect_to board_path(@board)
    end
  end

  private
    def set_board
      @board = current_user.boards.find(params[:board_id])
      redirect_to boards_path unless (!@board.nil?)
    end
end
