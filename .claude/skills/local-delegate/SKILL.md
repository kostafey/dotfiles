---
name: local-delegate
description: Offload long-output deterministic commands (test suites, builds, log scans, large diffs) to a local model and read only a structured summary. Use `pi-delegate run -- <cmd>` whenever a command is expected to print more than ~50 lines. Use `pi-delegate ask "<task>"` for an investigation whose details you don't need in context. If it exits 3, run the command yourself.
---

# Local delegate

`pi-delegate` hands noisy work to a small local model (driven by Pi on
llama.cpp) and prints only a short summary. The raw output stays in a log file.

## `run`: a command whose output you only need summarized

```sh
pi-delegate run -- sbt test
pi-delegate run --timeout 1800 -- sbt "testOnly *UserSpec"
pi-delegate run -- 'git log -p main..HEAD | grep -n TODO'
```

The command runs in the project root (git or pijul), whatever the current
directory. Several words are an argv; a single quoted argument is a shell
line, so pipes and `&&` work.

Long output comes back as:

```
STATUS: PASS | FAIL | ERROR
COMMAND: sbt test
EXIT: 1  DURATION: 83.2s
SUMMARY: 128 passed, 2 failed, 1 ignored
FAILURES:
- <test>: <one-line reason> (<file:line>)
NOTES: <warnings, or none>
LOG: <path>
```

STATUS, COMMAND, EXIT, DURATION and LOG come from the script. SUMMARY,
FAILURES and NOTES come from the small model: treat them as leads, not facts.
PASS means exit 0. FAIL means a nonzero exit and a test runner saying that
tests failed. ERROR means any other nonzero exit, e.g. a crash or a compile
error. Output under 40 lines skips the model: it is printed verbatim under
`OUTPUT:`.

For a failed command, `ERRORS` usually replaces FAILURES: lines quoted from
the whole log as `L<n>: <text>`, `<n>` being the line in the LOG, with
identical lines folded into `+ N more ...`. The text is always verbatim, so
fix the code from it, and `Read` the LOG around `L<n>` when you need the
context. Only the choice of lines differs:

- `ERRORS (verbatim from the LOG):` comes from patterns (ScalaTest,
  sbt/scalac, react-scripts, Python tracebacks) and is complete.
- `ERRORS (verbatim from the LOG, lines picked by the local model):` is the
  model's choice from keyword matches, widened by the script to lines of the
  same kind. It can miss an error: when SUMMARY counts more failures than
  the excerpt shows, `Grep` the LOG.

If STATUS is FAIL or ERROR and what came back is not enough, `Read` the
LOG path or `Grep` it. Don't rerun the command.

Test suites and builds take a while: pass `timeout: 600000` to the Bash tool,
or run in the background. Raise `--timeout` (default 600 s for the whole
operation) when a suite needs longer.

## `ask`: an investigation whose details you don't need

```sh
pi-delegate ask "Find out why the build fails on the scala-3.4 branch"
```

The local model works with `read` and `bash` only and answers in at most 20
lines. Each ask starts clean, so name in the task everything it needs.
`--session` goes on in the project's session with the earlier `--session`
asks, but the model holds on to what it said there, wrong conclusions
included; `pi-delegate reset` drops that session. It is a small model: it
finds things well (where X is, who calls Y, how many files do Z) and reasons
about runtime behaviour poorly. Give it narrow, checkable tasks, and verify
what matters before acting on it.

## Exit codes

- `0`: the summary or answer is on stdout.
- `2`: usage error.
- `3`: the local model is unavailable (llama-server down, `pi` missing,
  timeout). stderr says why. If stderr names a saved log, the command
  already ran, so `Grep` or `Read` that log instead of rerunning. Otherwise
  run the command yourself.
