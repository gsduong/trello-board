module CardsHelper
  def due_date_today(card)
    card.due_date == Date.today ? 'bg-red' : 'bg-green'
  end
end
