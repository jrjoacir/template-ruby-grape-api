# frozen_string_literal: true

FactoryBot.define do
  to_create(&:save)

  factory :project, class: Models::Project do
    name { 'Project' }
    description { 'Description' }
  end
end
