# pi-delegate

Hands noisy, deterministic work to a local model so that Claude Code reads a
short summary instead of hundreds of lines of output. The model is Qwen3.5-4B
on llama.cpp, driven by the Pi coding agent.

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

`pi-delegate run [--timeout S] -- COMMAND...` is deterministic: the script
runs COMMAND with `bash -lc` in the project root, saves the merged
stdout+stderr to a log, and only then asks the model to summarize the log.
The model never chooses what runs. Output under 40 lines is printed verbatim,
without the model. Longer output becomes a block:

```
STATUS: PASS | FAIL | ERROR
COMMAND: sbt test
EXIT: 1  DURATION: 6.6s
SUMMARY: 36 tests, 3 failed, 0 errors
FAILURES:
- <test>: <one-line reason> (<file:line>)
NOTES: none
LOG: ~/.cache/pi-delegate/<project>/<timestamp>-sbt-test.log
```

The script writes STATUS, COMMAND, EXIT, DURATION and LOG itself. The model
writes SUMMARY, FAILURES and NOTES, and sees neither the exit code nor the
status: a 4B model told that a command failed invents a failure to report.
A FAILURES line whose name occurs nowhere in the log is dropped, and NOTES
says so. At most 15 FAILURES lines are kept, then "- ... and N more".

When the command fails, an excerpt quoted verbatim from the log takes the
place of FAILURES. It is cut from the whole log, not from what the model got,
and each line carries its line number in the LOG:

```
ERRORS (verbatim from the LOG):
L29: [info] <suite> *** ABORTED ***
L30: [info]   <exception>: <message>
  + 38 more ABORTED with the same reason: <suite> (L112), ...
```

The lines come from the first of these that yields any:

1. ScalaTest's `*** FAILED ***` and `*** ABORTED ***`, each with the reason
   line under it. Entries of one kind with the same reason fold into one.
2. When no test runner says that tests failed (see STATUS below), build
   errors: sbt/scalac `[error]` lines (no stack frames, no `Total time`),
   react-scripts' `Failed to compile.` with the 8 non-blank lines after it,
   and of each Python traceback its last frame, that frame's source line and
   the exception.
3. Any log: the script picks candidate lines by keyword (`error`,
   `exception`, `fail`, `assert`, `expected`, `cannot`, `not found`, ...; no
   stack frames, no zero counts such as `Errors: 0`), up to 120 groups of
   identical lines, and lists them with their numbers after the log. The
   model answers `ERROR_LINES:` with the numbers of the real errors, and the
   script quotes those lines under `ERRORS (verbatim from the LOG, lines
   picked by the local model):`. A number outside the list is dropped, so
   the model chooses lines but never writes them.

   The model tends to pick one line of a kind and miss the others, so every
   candidate of the same shape as a candidate in the excerpt joins it. The
   shape is the line up to its first keyword with each word or path masked:
   both errors of javac are `w:w: w`, both failures of JUnit's console
   launcher `    => w`. A shape of bare words (`w w`, as in "Build failed")
   does not count. Each line comes with up to 4 lines after it that are
   indented deeper (javac's source line and caret, JUnit's exception), and
   of a JVM stack trace only the first frame outside the JDK, Scala, Kotlin,
   test frameworks and build tools.

If none yields a line, the model's FAILURES stay. The excerpt is at most 30
lines of at most 240 characters. A green run has `[error]` lines too, logged
by the code under test, so a command that exits 0 gets no excerpt.

STATUS is the script's alone. PASS: exit 0, whatever the model says;
FAILURES lines it lists anyway go to NOTES. FAIL: a nonzero exit, and a test
runner's word that tests failed: the ScalaTest markers, sbt's
`TestsFailedException`, `N tests failed` (JUnit's console launcher),
Surefire's `Tests run: ..., Failures: N`, Gradle's `tests completed, N
failed`, pytest's `=== N failed`, jest's `Tests: N failed`, go's `--- FAIL:`,
cargo's `test result: FAILED`, clojure.test's `FAIL in (...)` and
`ERROR in (...)` (`lein test`), ERT's `N unexpected`. ERROR: any other
nonzero exit, e.g. a compile error or a crash. Short output, printed
verbatim, gets its STATUS the same way.

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

Only the summary goes to stdout, diagnostics go to stderr. Exit codes:

- `0`: summary printed.
- `2`: usage error.
- `3`: the local model is unavailable (llama-server down, `pi` missing,
  timeout). In `run` mode the command still runs: short output is printed as
  usual, and long output is saved with its log path on stderr.

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
