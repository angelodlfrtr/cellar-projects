class SettingsController < ApplicationController
  before_action :set_as_setting, :find_project

  private

    def set_as_setting
      @settings_controller = true
    end
end
