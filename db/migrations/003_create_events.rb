Sequel.migration do
  up do
    create_table :events do
      primary_key :id
      foreign_key :computer_id, :computers
      String :type, null: false
      String :data, text: true
      DateTime :occurred_at, null: false
    end
  end

  down do
    drop_table :events
  end
end
