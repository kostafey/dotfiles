---
name: local-delegate
description: Run long-output deterministic commands (test suites, builds, log scans, large diffs) through `pi-delegate run -- <cmd>` and read only a short report quoted from the log, whenever a command is expected to print more than ~50 lines. Use `pi-delegate ask "<task>"` to hand an investigation whose details you don't need in context to a local model. If it exits 3, read the log it names or run the command yourself.
---

# Local delegate

`pi-delegate run` runs a noisy command and prints a short report of its log;
the raw output stays in a log file. `pi-delegate ask` hands an investigation
to a small local model (driven by Pi on llama.cpp).

## `run`: a command whose output you only need the gist of

```sh
pi-delegate run -- sbt test
pi-delegate run --timeout 1800 -- sbt "testOnly *UserSpec"
pi-delegate run -- 'git log -p main..HEAD | grep -n TODO'
```

The command runs in the project root (git or pijul), whatever the current
directory. Several words are an argv; a single quoted argument is a shell
line, so pipes and `&&` work.

Output under 40 lines is printed verbatim under `OUTPUT:`. Longer output
comes back as a report:

```
STATUS: PASS | FAIL | ERROR
COMMAND: sbt test
EXIT: 1  DURATION: 83.2s
SUMMARY (verbatim from the LOG):
L5956: [info] Tests: succeeded 82, failed 1, canceled 0, ignored 0, pending 0
L5957: [info] *** 1 TEST FAILED ***
ERRORS (verbatim from the LOG):
L5853: [info] - <test> *** FAILED ***
L5854: [info]   <reason> (<File.scala:316>)
LOG: <path>
```

The script writes every line of it; no model is involved. Each quoted line is
`L<n>: <text>`, `<n>` being its line in the LOG, and `+ N more like it: L..`
folds identical lines. The text is verbatim, so act on it, and `Read` the LOG
around `L<n>` when you need the context.

- STATUS: PASS means exit 0. FAIL means a nonzero exit and a test runner
  saying that tests failed. ERROR means any other nonzero exit, e.g. a crash
  or a compile error.
- SUMMARY: the closing lines of known test runners and build tools, the
  last of each kind. `none` when the log has no such line.
- ERRORS, for a failed command. `ERRORS (verbatim from the LOG):` comes from
  patterns (ScalaTest; Maven's failed tests, compiler errors and the cause of
  a failed goal; sbt/scalac; react-scripts; Python tracebacks) and is
  complete. `ERRORS (keyword lines from the LOG, not all of them errors):`
  is every line with a word like error, fail or expected, for formats the
  patterns don't know; over 30 lines it keeps the first and the last ones.
- LOGGED ERRORS, for a passing command: lines a logger marked as errors. The
  code under test logs them in a green run too, so they are worth a glance,
  not a failure.
- TAIL: the last 8 lines, when there is no SUMMARY line or the output goes
  on past it, as a deploy script running several builds does.
- WARNINGS: how many lines a logger marked as warnings.

If what came back is not enough, `Read` the LOG path or `Grep` it. Don't
rerun the command.

`--model` has the local model write SUMMARY, FAILURES and NOTES instead.
Their text is the model's retelling and can be wrong, so prefer the report
and `Grep` the LOG.

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

- `0`: the report or answer is on stdout.
- `2`: usage error.
- `3`: the command timed out and was killed, or the local model is
  unavailable for `ask` or `run --model` (llama-server down, `pi` missing,
  timeout). stderr says why. If stderr names a saved log, the command
  already ran, so `Grep` or `Read` that log instead of rerunning. Otherwise
  run the command yourself.
