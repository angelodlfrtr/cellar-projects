class Settings < Settingslogic
  source "#{Rails.root}/config/cellar.yml"
  namespace Rails.env
end
