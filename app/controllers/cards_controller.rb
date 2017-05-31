class CardsController < ApplicationController
  before_action :set_card, :only => [:edit, :update]
  before_action :require_member
  before_action :require_owner, :only => [:edit, :update]

  def new
    @card = Card.new
  end

  def edit

  end

  def create
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
    if @card.update(params.require(:card).permit(:title, :list_id, :due_date, :description, :progress ))
      flash[:success] = 'Successfully updated list!'
      redirect_to board_path(@board)
    end
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def require_owner
      redirect_to board_path(@board) unless (@card.belong_to?(current_user))
    end

    def require_member
      @board = Board.find_by(params[:board_id])
      redirect_to root_url unless (!@board.nil?)

      redirect_to board_path(@board) unless (current_user.is_member?(@board))
    end
end
