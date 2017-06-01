class Admin::MembersController < ApplicationController
  before_action :require_login
  before_action :set_board
  before_action :require_admin


  def new

  end

  def create
    user_id = params[:member_id]
    if User.find_by(id: user_id).nil?
    #   User not exist
    else
      if BoardMember.find_by(board_id: @board.id, member_id: user_id).nil?
        board_member = BoardMember.new(board_id: @board.id, member_id: user_id, admin: false)
        board_member.save

      else
      #   Dont save this
      end
    end
    flash[:success] = 'Member successfully added to board!'
    redirect_to admin_board_path(@board)
  end

  def destroy
    @member = User.find(params[:id])
    if @member != current_user
      if (board_member = BoardMember.find_by(board_id: @board.id, member_id: @member.id))
          board_member.destroy
      end

      @board.lists.each do |list|
        list.cards.each do |card|
          card.card_members.where(member_id: @member.id).delete_all
        end
      end
    end
    flash[:success] = 'Successfully removed user!'
    redirect_to admin_board_path(@board)
  end

  private
    def require_admin
      board = current_user.boards.find(params[:board_id])
      redirect_to admin_board_path(board) unless current_user.is_admin?(board)

    end

    def set_board
      @board = current_user.boards.find(params[:board_id])
      redirect_to boards_path unless (!@board.nil?)
    end

    def set_member
      @member = @board.users.find(params[:id])
      redirect_to admin_board_path unless (!@member.nil?)
    end

end
