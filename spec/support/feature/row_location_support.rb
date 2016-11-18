module Feature
  module RowLocationSupport
    # Provide a more readable way to access the row position in a table within
    # feature tests.

    # It expects to receive an integer for the row number the test should check
    # as well as an optional block for what is to occur within that row.
    def in_table_row_number(row_number)
      within("tr:nth-child(#{row_number})") { yield }
    end
  end
end
