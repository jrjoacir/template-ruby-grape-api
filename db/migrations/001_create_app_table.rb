Sequel.migration do
  up do
    create_table(:app) do
      primary_key :id
      String :name, null: false
      String :description
    end
  end

  down do
    drop_table(:app)
  end
end
