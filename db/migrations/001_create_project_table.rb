# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:project) do
      primary_key :id
      String :name, null: false
      String :description
    end
  end

  down do
    drop_table(:project)
  end
end
