### The rollback and data restore options

The declarative schema does exactly what you’ve written. This is a big advantage and, at the same time, the biggest flaw of the declarative approach.

The problem is: everybody can make a mistake. A developer can accidentally delete a column or other structural element. That would lead only to the data loss but to the error in the system.

What declarative schema offers is an option of safe installation and rollback. In this case, the system will store all the changes being made in a CSV file.

To start the safe mode, run the command:

--safe-mode=1

To perform the rollback, run (only used with the setup:upgrade command):

--data-restore=1

After that, run:

setup:upgrade --data-restore=1

In the safe mode, Magento will create a CSV file that will contain details about the destructive operation that occurred. Such operations are:

    deleting a table,
    deleting a column,
    reducing column length,
    changing column precision,
    changing column type.

If any of these processes happen, developers will be able to track the change down and roll back to the previous version safely. The CVS files will be located in one of these locations:

Magento_root/var/declarative_dumps_csv/{column_name_column_type_other_dimensions}.csv

Magento_root/var/declarative_dumps_csv/{table_name}.csv

As for the rollback, the declarative schema allows a rollback to the previous version in case something goes wrong during the release.