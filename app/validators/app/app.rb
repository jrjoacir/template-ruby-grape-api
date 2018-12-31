module Validators
  module App
    def already_exist!
      raise StandardError, 'App already exists' if Models::App.first
    end

    def not_found!
      raise StandardError, 'App does not exist' unless app
    end
  end
end
