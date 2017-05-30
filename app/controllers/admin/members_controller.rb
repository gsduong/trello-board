class Admin::MembersController < ApplicationController
  before_action :set_board, :only => [:new, :create, :destroy]
  before_action :set_member, :only => [:destroy]
  before_action :require_admin, :only => [:new, :create, :destroy]


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
    redirect_to admin_board_path(@board)
  end

  def destroy
    if @member.id != current_user.id
      if (board_member = BoardMember.find_by(board_id: @board.id, member_id: @member.id))
          board_member.destroy
      end
    end
    redirect_to admin_board_path(@board)
  end

  private
    def require_admin
      board = Board.find(params[:board_id])
      redirect_to admin_board_path(board) unless current_user.is_admin?(board)

    end

    def set_board
      board_id = params[:board_id]
      @board = Board.find(board_id)
      redirect_to admin_board_path unless (!@board.nil?)
    end

    def set_member
      member_id = params[:id]
      @member = User.find(member_id)
      redirect_to admin_board_path unless (!@member.nil?)
    end

end
