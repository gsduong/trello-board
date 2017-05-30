module BoardsHelper
  def added_time(user, board)
    @board.board_members.find_by(board_id: board.id, member_id: user.id).created_at.strftime('%b %d, %Y')
  end
end
