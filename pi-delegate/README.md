# pi-delegate

Runs noisy commands for Claude Code and prints a short report of their log
instead of hundreds of lines of output, and hands investigations to a local
model. The model is Qwen3.5-4B on llama.cpp, driven by the Pi coding agent.

Files, in this directory of the dotfiles:

- `pi-delegate`: the script (Python 3, stdlib only), linked from
  `~/.local/bin/pi-delegate`.
- `pi-delegate-ask.md`: the system prompt appended in `ask` mode. The script
  finds it next to its own real path, so it needs no link.
- `../.claude/skills/local-delegate/SKILL.md`: tells Claude Code when and how
  to use it; the directory is linked from `~/.claude/skills/local-delegate`.
  `~/.claude/CLAUDE.md` points at the skill.

`install.sh` creates both links.

## Modes

`pi-delegate run [--timeout S] [--model] -- COMMAND...` runs COMMAND with
`bash -lc` in the project root and saves the merged stdout+stderr to a log.
Output under 40 lines is printed verbatim. Longer output becomes a report,
and every line of it is the script's:

```
STATUS: PASS | FAIL | ERROR
COMMAND: sbt test
EXIT: 0  DURATION: 165.1s
SUMMARY (verbatim from the LOG):
L2362: [info] Tests: succeeded 987, failed 0, canceled 0, ignored 1, pending 0
L2363: [info] All tests passed.
L2364: [success] Total time: 158 s (02:38), completed Nov 7, 2026, 9:57:44 PM
  + 2 more like it: L8, L12
LOGGED ERRORS: 10 lines, though the command passed:
L153: [error] [07.11.2026 21:55:58] XML Validation is FAIL for ...
  + 7 more like it: L178, L189, L192, ...
WARNINGS: 5 lines
LOG: ~/.cache/pi-delegate/<project>/<timestamp>-sbt-test.log
```

The report has no model in it. A 4B model's retelling of a log has to be
checked against the log anyway (it once reported the oldest of a list of
restic snapshots as the one restored), while a quoted line is right by
construction. Each quoted line is `L<n>: <text>`, `<n>` being its line in
the LOG, cut at 240 characters. The blocks:

- SUMMARY: the closing lines of test runners and build tools (ScalaTest and
  sbt, JUnit's console launcher, Maven with Surefire's totals and the module
  that failed in the reactor, Gradle, pytest, unittest, jest, go test, cargo
  test, clojure.test, ERT, react-scripts, webpack), at most 8 kinds. A kind
  is the line up to its first digit: of each kind the last line is quoted
  and the earlier ones fold under it, since sbt prints `Total time` after
  every task and react-scripts `Compiled successfully.` after every build.
  Without such a line SUMMARY says `none`.
- ERRORS, for a failed command: see below.
- LOGGED ERRORS, for a passing command: the lines a logger marked as errors
  (`[error]`, `[ERROR]`, a level `ERROR`, `FATAL` or `SEVERE`), which the
  code under test logs in a green run too. Lines that differ only in their
  numbers fold into one kind; at most 5 kinds are quoted.
- TAIL: the last 8 non-blank lines, when there is no SUMMARY line or the
  output goes on for more than 2 lines past the last one, as a script of
  several builds does. Lines already quoted, their copies and a tool's
  epilogue (Maven's separators, its advice to rerun with `-e` or `-X`, its
  help links) neither count nor show.
- WARNINGS: the number of lines a logger marked as warnings.

For a failed command ERRORS are cut from the whole log by the first of these
that yields any:

1. ScalaTest's `*** FAILED ***` and `*** ABORTED ***`, each with the reason
   line under it. Entries of one kind with the same reason fold into one:

   ```
   ERRORS (verbatim from the LOG):
   L29: [info] <suite> *** ABORTED ***
   L30: [info]   <exception>: <message>
     + 38 more ABORTED with the same reason: <suite> (L112), ...
   ```
2. Maven: the `Results` sections of Surefire and Failsafe (`Failures:`,
   `Errors:`, `Flakes:`, and Surefire 2.x's unprefixed `Failed tests:` and
   `Tests in error:`) with their `Class.method:line message` entries; the
   source errors of the compiler plugins (javac's `Foo.java:[3,25]`,
   scalac's `Foo.scala:3:`, kotlinc's `Foo.kt:3:5`) with the deeper-indented
   lines under them, once each, since Maven prints them before and after
   BUILD FAILURE; and the cause under `Failed to execute goal`, `The build
   could not read` and `Some problems were encountered` (an unresolvable
   dependency, a broken POM), without Maven's advice after it.
3. When no test runner says that tests failed (see STATUS below), build
   errors: sbt/scalac `[error]` lines (no stack frames, no `Total time`),
   react-scripts' `Failed to compile.` with the 8 non-blank lines after it,
   and of each Python traceback its last frame, that frame's source line and
   the exception.
4. Any log: candidate lines by keyword (`error`, `exception`, `fail`,
   `assert`, `expected`, `cannot`, `not found`, ...; no stack frames, no zero
   counts such as `Errors: 0`), identical lines folded, under `ERRORS
   (keyword lines from the LOG, not all of them errors):`. Each comes with up
   to 4 lines after it that are indented deeper (javac's source line and
   caret, clojure.test's `actual:`), and of a JVM stack trace only the first
   frame outside the JDK, Scala, Kotlin, test frameworks and build tools.
   Over 30 lines, a third goes to the first of them and the rest to the
   last: a compiler's first error is the cause, a program's last one is
   where it stopped.

STATUS is the script's alone. PASS: exit 0. FAIL: a nonzero exit, and a test
runner's word that tests failed: the ScalaTest markers, sbt's
`TestsFailedException`, `N tests failed` (JUnit's console launcher),
Surefire's `Tests run: ..., Failures: N`, Gradle's `tests completed, N
failed`, pytest's `=== N failed`, jest's `Tests: N failed`, go's `--- FAIL:`,
cargo's `test result: FAILED`, clojure.test's `FAIL in (...)` and
`ERROR in (...)` (`lein test`), ERT's `N unexpected`. ERROR: any other
nonzero exit, e.g. a compile error or a crash. Short output, printed
verbatim, gets its STATUS the same way.

Measured on 2026-11-07 on the 57 logs saved by then (sbt and ScalaTest,
`lein test`, ERT, `make test`, a `run.py` deploy, a Python crash) and on
Maven 3.9.9 builds made for the purpose (javac errors, Surefire 3.2.5 and
2.19.1 failures, a multi-module reactor with and without `-fae`, `-q`, an
unresolvable dependency, a broken POM): every quoted line matched its line
in the LOG, and the longest report took 30 lines (ERT, 4 failed tests with
their conditions). scalac and kotlinc under Maven were not run.

### `run --model`

With `--model` the local model writes SUMMARY, FAILURES and NOTES in place of
the report's SUMMARY, LOGGED ERRORS, TAIL and WARNINGS:

```
SUMMARY: 36 tests, 3 failed, 0 errors
FAILURES:
- <test>: <one-line reason> (<file:line>)
NOTES: none
```

The model sees neither the exit code nor the status: a 4B model told that a
command failed invents a failure to report. A FAILURES line whose name
occurs nowhere in the log is dropped, and NOTES says so. At most 15
FAILURES lines are kept, then "- ... and N more". A FAILURES line in a
passing run goes to NOTES.

ERRORS of a failed command come from the same patterns 1 to 3. In place of
pattern 4 the script lists the candidate lines, up to 120 groups of
identical lines, with their numbers after the log. The model answers
`ERROR_LINES:` with the numbers of the real errors, and the script quotes
those lines under `ERRORS (verbatim from the LOG, lines picked by the local
model):`. A number outside the list is dropped, so the model chooses lines
but never writes them. If no pattern yields a line, the model's FAILURES
stay.

The model tends to pick one line of a kind and miss the others, so every
candidate of the same shape as a candidate in the excerpt joins it. The
shape is the line up to its first keyword with each word or path masked:
both errors of javac are `w:w: w`, both failures of JUnit's console launcher
`    => w`. A shape of bare words (`w w`, as in "Build failed") does not
count. Each line comes with its deeper-indented lines and stack frame, as in
pattern 4.

Measured on 2026-11-01 with javac (two errors) and JUnit's console launcher
(two failed tests): before the shape rule the excerpt named every error in 1
of 2 javac runs and 2 of 3 JUnit runs, with it in 5 of 5 and 4 of 4. A flat
format with no indentation (a hand-written munit-like log) stayed uneven:
the model picked the assertion line in one run, sbt's summary in the other.

The model gets the log without terminal escapes and overwritten progress
lines. Logs that don't fit lose their middle: the first 2 000 characters stay,
and as much of the tail as fits. The limit is half of the server's `n_ctx`
(from `/props`) at 3 characters per token, capped at 96 000 characters, or
24 000 characters when `/props` doesn't answer.

### `ask`

`pi-delegate ask [--timeout S] [--session] "TASK"` is agentic: Pi gets the
task with the `read` and `bash` tools only (no `edit`/`write`) and answers in
at most 20 lines. The script cuts the answer after 40 lines. Each ask starts
clean. With `--session` it goes on in the project's persistent session
instead, along with the earlier `--session` asks. The memory is opt-in
because a small model holds on to what it said before: tested on 2026-11-01,
it kept defending a wrong conclusion against a premise stated outright, and
answered a later question by an earlier "reply only with OK".

`pi-delegate reset` drops the project's `ask` session. A session file above
2 MB is dropped automatically before the next `--session` ask, with a note
on stderr.

Only the report or the answer goes to stdout, diagnostics go to stderr. Exit
codes:

- `0`: report or answer printed.
- `2`: usage error.
- `3`: COMMAND timed out and was killed (its partial log on stderr), or the
  local model is unavailable for `ask` or `run --model` (llama-server down,
  `pi` missing, timeout). With `--model` the command still runs: short
  output is printed as usual, and long output is saved with its log path on
  stderr.

In `run` mode the STATUS line carries the command's outcome; the exit code
is only about the delegate.

## Where things live

The project root is the git top level, else the nearest `.pijul` directory,
else the current directory. Per-project state is keyed by
`<root name>-<8 hex of sha1(root path)>`.

- Logs: `${XDG_CACHE_HOME:-~/.cache}/pi-delegate/<key>/`, the last 30 per
  project.
- Sessions: `${XDG_STATE_HOME:-~/.local/state}/pi-delegate/sessions/<key>/`.
  This is a `--session-dir` of its own, so the delegate never shows up in the
  `pi -r` picker. The session id is `claude-delegate`.
- Locks: `${XDG_STATE_HOME:-~/.local/state}/pi-delegate/locks/<key>.lock`.
  One delegate runs per project at a time; others wait within their
  `--timeout`.

## Model

The script pins `--provider local --model qwen3.5-4b --thinking off -ne -ns
-np --no-mcp --no-approve` on every Pi call. With the provider pinned, Pi
never reaches a cloud model; even an unknown model id goes to the same
llama-server. Context files (`AGENTS.md`, `CLAUDE.md`) stay enabled. The
health check reads the server address from the `local` provider's `baseUrl`
in `~/.pi/agent/models.json`.

To change the model, edit `PROVIDER` and `MODEL` at the top of the script,
and the provider in `~/.pi/agent/models.json`.

## Startup time and the RPC daemon

Measured on 2026-11-01: `pi -p --no-session --no-tools "say ok"` with the
pinned flags, ten runs, took a median of 0.39 s (min 0.38 s, max 0.93 s) for
the whole call, model answer included. Pi itself starts in 0.27 s
(`--list-models`). That is under the 1.5 s threshold, so there is no RPC
daemon: every call is a one-shot `pi -p`.

For reference, RPC mode was checked once. The stream matched the docs:
`prompt` answers `{"disposition": "started"}`, text arrives in
`message_update` / `text_delta`, then `agent_end`, then `agent_settled`.
