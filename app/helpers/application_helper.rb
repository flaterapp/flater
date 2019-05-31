module ApplicationHelper
  # helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # CUSTOM GLOBAL METHODS
  def short_text(text, size = 40)
    return text.length > size ? "#{text.first(size / 2)}... #{text.last(size / 3)}" : text
  end

  def badge(data, format = 'primary', icon = '', link = '', hide = true)
    badge_class = "badge-custom badge-#{format}"
    icon = "<i class=\"fas fa-#{icon}\"></i>" if icon != ''
    data = hide ? "<strong>#{data}</strong>" : "<b>#{data}</b>"
    if link != ''
      "<a href=\"#{link}\" class=\"#{badge_class}\">#{icon}#{data}</a>"
    else
      "<span class=\"#{badge_class}\">#{icon}#{data}</span>"
    end
  end
end
