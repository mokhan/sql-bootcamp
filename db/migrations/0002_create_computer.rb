Sequel.migration do
  up do
    create_table :computers do
      primary_key :id
      TrueClass :active, null: false, default: true
      #foreign_key :business_id, :businesses
      Integer :business_id # intentionally remove foreign key to allow for orphan rows.
    end
  end

  down do
    drop_table :computers
  end
end
