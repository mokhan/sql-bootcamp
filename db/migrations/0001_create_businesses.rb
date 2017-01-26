Sequel.migration do
  up do
    create_table :businesses do
      primary_key :id
      String :name, null: false
      Integer :business_relationship_id, null: false
    end
  end

  down do
    drop_table :businesses
  end
end
