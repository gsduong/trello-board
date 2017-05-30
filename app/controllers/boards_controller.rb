class BoardsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: [:show]
  before_action :is_member, only: [:show]

  # GET /boards
  def index
    board_ids = []
    admin_board_ids = []
    current_user.board_members.each do |record|
      if record.admin
        admin_board_ids << record.board_id
      else
        board_ids << record.board_id
      end
    end
    @boards = Board.by_ids(board_ids)
    @admin_boards = Board.by_ids(admin_board_ids)
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # POST /boards
  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:success] = 'Successfully created board!'
      board_member = BoardMember.new(:board_id => @board.id, :member_id => current_user.id)
      board_member.save
      redirect_to boards_path
    else
      # render 'new'
    end
  end

  # GET /boards/1
  def show
    @board = Board.find(params[:id])
    admin_id = @board.board_members.find_by(board_id: @board.id, admin: true)[:member_id];
    @admin = User.find(admin_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find_by(id: params[:id])
      redirect_to root_url unless (!@board.nil?)
    end

  def board_params
    params.require(:board).permit(:name, :description)
  end

  # Check if user can view this board or not
  def is_member
    @user = User.find(current_user.id)
    board_id = params[:id]
    redirect_to(root_url) unless (!@user.boards.find_by(id: board_id).nil?)
  end

end
