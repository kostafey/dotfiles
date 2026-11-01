## Databases

Reach databases only through the `ejc-sql` MCP server, never by other means
(psql, mysql, sqlplus, JDBC or database drivers in scripts). If the server is
unavailable, or the database is missing from `list_connections`, ask me to
connect to it with `M-x ejc-connect` in Emacs.

## Long command output

Commands expected to print more than ~50 lines (test suites, builds, log
scans, large diffs) go through `pi-delegate`: see the `local-delegate` skill.
