class ApplicationDecorator < Draper::Decorator
  delegate_all

  def date_of_creation
    created_at.strftime('%Y/%m/%d')
  end
end
