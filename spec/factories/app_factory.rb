# frozen_string_literal: true

FactoryBot.define do
  to_create(&:save)

  factory :app, class: Models::App do
    name { 'App' }
    description { 'Description' }
  end
end
