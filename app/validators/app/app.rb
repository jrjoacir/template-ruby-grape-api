module Validators
  module App
    def already_exist!
      already_exist_error if Models::App.first
    end

    def not_found!
      not_found_error unless app
    end

    private

    def already_exist_error
      raise Errors::AlreadyExist, 'App already exists'
    end

    def not_found_error
      raise Errors::NotFound, 'App does not exist'
    end
  end
end
