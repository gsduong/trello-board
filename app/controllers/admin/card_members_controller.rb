class Admin::CardMembersController < ApplicationController

  before_action :set_board

  def new
    @card_member = CardMember.new
    @card = Card.find(params[:card_id])
  end

  def create

    @card = Card.find(params[:card_id])

    redirect_to admin_board_path(@board) unless @card.list.board.id == @board.id

    member_id = params.require(:card_member).permit(:member_id)[:member_id]

    member = User.find(member_id)

    card_member = CardMember.find_by(card_id: @card.id, member_id: member.id)

    if card_member.nil?

      card_member = CardMember.new(card_id: @card.id, member_id: member_id)
      if card_member.save
        flash[:success] = 'Successfully added user to card!'
      else
        flash[:error] = 'Failed!'
      end

    else
      flash[:error] = 'User already in card!'
    end
    redirect_to admin_board_path(@board)

  end

  def destroy
    @card = Card.find_by(params[:card_id])

    if current_user.is_admin?(@card.list.board)
      CardMember.where(:card_id => params[:card_id], :member_id => params[:id]).destroy_all
    end

    # if !@card_member.nil?
    #   @card_member.destroy
    # end

    flash[:success] = 'Successfully removed user from card!'

    redirect_to admin_board_path(@board)
  end

  private
    def set_board
      @board = Board.find(params[:board_id])
    end


end
