module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end
  def admins_only(&block)
    block.call if current_user.try(:admin?) # try if current_user is set AND admin=true
  end
end
