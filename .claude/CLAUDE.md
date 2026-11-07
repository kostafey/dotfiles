## Reply language

I write in Russian or in English; always answer me in Russian, whatever the
language of my message. This covers chat replies only: code, comments, commit
messages, logs and documentation follow the conventions of the project.
Technical terms inside Russian text stay in English (`iframe`, `commit`), not
calques.

## Databases

Reach databases only through the `ejc-sql` MCP server, never by other means
(psql, mysql, sqlplus, JDBC or database drivers in scripts). If the server is
unavailable, or the database is missing from `list_connections`, ask me to
connect to it with `M-x ejc-connect` in Emacs.

## Long command output

Commands expected to print more than ~50 lines (test suites, builds, log
scans, large diffs) go through `pi-delegate`: see the `local-delegate` skill.
