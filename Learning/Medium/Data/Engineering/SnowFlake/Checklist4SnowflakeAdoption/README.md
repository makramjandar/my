# CheckList for SnowFlake Adoption

## Define the ACCOUNTADMIN Role
> The account administrator (ACCOUNTADMIN) role is the most powerful role in the system. This role alone is responsible for configuring parameters at the account level. Users with the ACCOUNTADMIN role can view and operate on all objects in the account, can view and manage Snowflake billing and credit data, and can stop any running SQL statements.
`Assign this role to at least 2 users`
> We follow strict security procedures for resetting a forgotten or lost password for users with the ACCOUNTADMIN role. These procedures can take up to two business days. Assigning the ACCOUNTADMIN role to more than one user avoids having to go through these procedures because the users can reset each other’s passwords.
**References:**
*[Control the assignment of the accountadmin role to users] [1]
[Using the accountadmin role] [2]
[Designating additional users as account administrators] [3]*


[1]: https://docs.snowflake.net/manuals/user-guide/security-access-control-considerations.html#control-the-assignment-of-the-accountadmin-role-to-users
[2]: https://docs.snowflake.net/manuals/user-guide/security-access-control-considerations.html#using-the-accountadmin-role
[3]: https://docs.snowflake.net/manuals/user-guide/security-access-control-configure.html#designating-additional-users-as-account-administrators
[4]: http://example.org/ "Title"

