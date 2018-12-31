module Validators
  module App
    def already_exist!
      raise Errors::Business::AlreadyExist, 'App already exists' if Models::App.first
    end

    def not_found!
      raise Errors::Business::NotFound, 'App does not exist' unless app
    end
  end
end
