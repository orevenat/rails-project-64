module CommentsHelper
  def format_comment_date(date)
    I18n.l(date, format: :short)
  end
end
