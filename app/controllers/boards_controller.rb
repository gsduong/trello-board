class BoardsController < ApplicationController
  before_action :require_login
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
    @boards = current_user.boards.by_ids(board_ids)
    @admin_boards = current_user.boards.by_ids(admin_board_ids)
  end

  # GET /boards/new
  def new
    @board = current_user.boards.new
  end

  # POST /boards
  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      flash[:success] = 'Successfully created board!'
      board_member = BoardMember.new(:board_id => @board.id, :member_id => current_user.id)
      board_member.save
      redirect_to admin_board_path(@board)
    else
      # render 'new'
    end
  end

  # GET /boards/1
  def show
    @board = current_user.boards.find(params[:id])
    @admin = BoardMember.find_by(board_id: @board.id, admin: true).user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def board_params
      params.require(:board).permit(:name, :description)
    end

    # Check if user can view this board or not
    def is_member
      board_id = params[:id]
      redirect_to(root_url) unless (!current_user.boards.find_by(id: board_id).nil?)
    end

end
