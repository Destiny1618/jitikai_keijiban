class AddTelephoneNumberToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :telephone_number, :string
  end
end
