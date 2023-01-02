// go get github.com/fatih/color
// go build -o ./gitall.go

package main

import (
    "fmt"
    "github.com/fatih/color"
    "io/ioutil"
    "os"
    "os/exec"
    "path/filepath"
    "strings"
    "time"
    "sort"
    "regexp"
)

func help() {
    fmt.Printf(`Gitall - handle many git repositories project case.
Apply for all repos in subfolders and all branches.

Usage:
  gitall <action> [<attr>] [<params>]

Actions:
  log      - Show log commits filtered by commit message with <attr> substring.
  diff     - Show diffs for all commits filtered by commit message with
             <attr> substring.
  help     - Show this help.
  barnch   - Show branches list and current branch.
  checkout - Change current branch.
  pull
  status
  last     - Show last commit ordered for projects by time asc.
  work     - Show all my commits by time asc (work history).

Params:
  -a
  -all    - Apply to all subfolders (single nested level).
  -l
  --local - Apply to current folder.

Examples:
  gitall checkout -b develop
          Checkout to develop branch, keep all changes.
  gitall branch -a
          Show all branches.
`)
}

func getExPath() string {
    f, _ := os.Open(".")
    return f.Name()
}

func diffColorizePrint(result string) {
    for _, line := range strings.Split(
        strings.TrimSuffix(result, "\n"), "\n") {
        if len(line) > 0 {
            if line[0] == '-' {
                color.Red(line)
            } else if line[0] == '+' {
                color.Green(line)
            } else {
                fmt.Printf(line)
                fmt.Printf("\n")
            }
        }
    }
}

func run(dir string, name string, arg ...string) string {
    cmd := exec.Command(name, arg...)
    cmd.Dir = dir
    out, _ := cmd.Output()
    result := string(out)
    return result
}

func header(dir string) {
    fmt.Printf("---------------------------------------\n")
    color.Yellow(dir)
}

type summary struct {
    count     int
    artifacts []string
}

var s = summary{count: 0, artifacts: []string{}}

func updateSummary(dir string) {
    if !in(dir, s.artifacts) {
        s.count++
        s.artifacts = append(s.artifacts, dir)
    }
}

func affected() {
    fmt.Printf("---------------------------------------\n")
    color.Cyan("Total affected: %d", s.count)
    color.White("%s\n", strings.Join(s.artifacts[:], "\n"))
}

func isClean(dir string) bool {
    return strings.Contains(
        run(dir, "git", "status"),
        "nothing to commit, working tree clean")
}

func isGit(dir string) bool {
    result := run(dir, "git", "status")
    return !(result == "" || strings.Contains(result, "Not a git repository"))
}

func gitGrep(dir string, search string, diff string) {
    repoDir := filepath.Join(getExPath(), dir)
    result := run(repoDir, "git", "log", "--all", fmt.Sprintf("--grep=%s", search))
    if result != "" {
        updateSummary(dir)
        if isTrue(diff) {
            for _, line := range strings.Split(
                strings.TrimSuffix(result, "\n"), "\n") {
                if strings.Contains(line, "commit ") {
                    commitHash := strings.Split(line, "commit ")[1]
                    result := run(repoDir, "git", "show", commitHash)
                    header(dir)
                    diffColorizePrint(result)
                }
            }
        } else {
            header(dir)
            fmt.Printf("%s\n", result)
        }
    }
}

func branch(currentDir string, params string) {
    repoDir := filepath.Join(getExPath(), currentDir)
    result := run(repoDir, "git", "branch")
    if result != "" {
        lines := strings.Split(strings.TrimSuffix(result, "\n"), "\n")
        color.Yellow(currentDir)
        for _, line := range lines {
            if len(line) > 0 {
                if line[0] == '*' {
                    color.Green(line + "\n")
                }
                if in(params, all) && line[0] != '*' {
                    color.White(line + "\n")
                }
            }
        }
    }
}

func getBranch(dir string) string {
    result := run(dir, "git", "branch")
    lines := strings.Split(strings.TrimSuffix(result, "\n"), "\n")
    for _, line := range lines {
        if len(line) > 0 {
            if line[0] == '*' {
                return strings.TrimSpace(strings.Split(line, " ")[1])
            }
        }
    }
    return ""
}

func checkout(dir string, params string, branch string) {
    repoDir := filepath.Join(getExPath(), dir)
    if getBranch(repoDir) == branch {
        return
    }
    header(dir)
    isClean := isClean(repoDir)
    stashName := ""
    if isClean {
        fmt.Printf("%s\n", "nothing to commit, working tree clean")
    } else {
        stashName = time.Now().Format("2006-01-02_15:04:05")
        run("git", "stash", "save", "\""+stashName+"\"")
        fmt.Printf("Stash: save ")
        color.Red(stashName + "\n")
    }
    if params == "" {
        run(repoDir, "git", "checkout", branch)
    } else {
        run(repoDir, "git", "checkout", params, branch)
    }
    fmt.Printf("Change branch: ")
    color.Green(branch + "\n")

    if !isClean {
        fmt.Printf("Stash: apply ")
        color.Green(stashName + "\n")
    }
}

func pull(dir string) {
    repoDir := filepath.Join(getExPath(), dir)
    result := run(repoDir, "git", "pull")
    header(dir)
    fmt.Printf("%s\n", result)
}

func status(dir string) {
    status := run(dir, "git", "status")
    if !strings.Contains(status, "nothing to commit, working tree clean") {
        updateSummary(dir)
        header(dir)
        fmt.Printf("%s\n", status)
    }
}

// Pair @unexported
type Pair struct {
    a, b string
}

// ByDate @unexported
type ByDate []Pair

func getCommitDate(p Pair) time.Time {
    commit := p.b
    d := ""
    for _, line := range strings.Split(commit, "\n") {
        if strings.Contains(line, "Date:") {
            d = strings.TrimSpace(strings.Split(line, "Date:")[1])
        }
    }
    t, _ := time.Parse("Mon Jan _2 15:04:05 2006 -0700", d)
    return t
}
// Len @unexported
func (s ByDate) Len() int {
    return len(s)
}
// Swap @unexported
func (s ByDate) Swap(i, j int) {
   s[i], s[j] = s[j], s[i]
}
// Less @unexported
func (s ByDate) Less(i, j int) bool {
    return getCommitDate(s[i]).Before(getCommitDate(s[j]))
}

var lastCommits []Pair

func getLastCommits(dir string) {
    result := run(dir, "git", "log", "-1")
    lastCommits = append(lastCommits, Pair{dir, result})
}

func filter(ss []string, test func(string) bool) (ret []string) {
    for _, s := range ss {
        if test(s) {
            ret = append(ret, s)
        }
    }
    return
}

func mapcar(ss []string, evalFn func(string)) (ret []string) {
    for _, s := range ss {
        evalFn(s)
    }
    return
}

func mapv(ss []string, evalFn func(string) string) (ret []string) {
    for _, s := range ss {
        ret = append(ret, evalFn(s))
    }
    return
}

func splitKeep(reStr string, s string, n int, take int) []string {
    re := regexp.MustCompile(reStr)

    if n == 0 {
        return nil
    }

    matches := re.FindAllStringIndex(s, n)
    strings := make([]string, 0, len(matches))

    beg := 0
    end := 0
    for _, match := range matches {
        if n > 0 && len(strings) >= n-1 {
            break
        }

        end = match[0]
        if match[1] != 0 {
            if (beg >= take) {
                beg = beg - take
            }
            strings = append(strings, s[beg:end])
        }
        beg = match[1]
    }

    if end != len(s) {
        strings = append(strings, s[beg:])
    }

    return strings
}

func getWorkHistory(dir string) {
    result := run(dir, "git", "log", "--all")
    commits := splitKeep(`commit [a-zA-Z0-9]{40}`, result, -1, 47)

    mycommitsFilter := func(s string) bool {
        return strings.Contains(s, "konstantin.sedykh") ||
            strings.Contains(s, "kostafey")
    }
    mycommits := filter(commits, mycommitsFilter)
    mapcar(mycommits, func(s string) {
        lastCommits = append(lastCommits, Pair{dir, s})
    })
}

const gitTimeFmt = "Mon Jan _2 15:04:05 2006 -0700"
const outputTimeFmt = "2006-01-02 15:04:05"

func sortLastCommits() {
    sort.Sort(ByDate(lastCommits))
    for _, p := range lastCommits {
        header(p.a)
        fmt.Printf("%s \n", p.b)
    }
}

func fixUpstream(dir string) {
    repoDir := filepath.Join(getExPath(), dir)
    branch := getBranch(repoDir)
    result := run(repoDir, "git", "branch",
        "--set-upstream-to=origin/"+branch, branch)
    header(dir)
    fmt.Printf("%s\n", result)
}

func in(val string, arr []string) bool {
    for _, v := range arr {
        if v == val {
            return true
        }
    }
    return false
}

func isTrue(s string) bool {
    return in(s, []string{"1", "t", "T", "true", "True"})
}

func isMvnRepo(dir string) bool {
    _, err := os.Stat(filepath.Join(getExPath(), dir, "pom.xml"));
    return err == nil
}

var mvnTotal = 0
var mvnDone = 0
var mvnOk = 0
var mvnFail = 0

func mvn(dir string, params []string) {
    if isMvnRepo(dir) {
        header(dir)
        result := run(dir, "mvn", params...)
        mvnDone++
        if strings.Contains(result, "BUILD SUCCESS") {
            mvnOk++
        } else if strings.Contains(result, "BUILD FAILURE") {
            mvnFail++
        }
        fmt.Printf("%s\n", result)
        color.Cyan("Mvn done: %d success: %d failed: %d of %d\n",
                mvnDone, mvnOk, mvnFail, mvnTotal)
    }
}

func countMvnDirs() {
    files, _ := ioutil.ReadDir("./")
    for _, f := range files {
        if f.IsDir() && isMvnRepo(f.Name())  {
            mvnTotal++;
        }
    }
}

func setMavenOptions() {
    exec.Command("set", "MAVEN_OPTS", "=", "-XX:+TieredCompilation", "-XX:TieredStopAtLevel=1")
}

// TN @unexported
type TN struct{}

// T1 @unexported
type T1 struct{}

// T2 @unexported
type T2 struct{}

// T3 @unexported
type T3 struct{}

func (t TN) traverse(fu func(string, []string), params []string) {
    files, _ := ioutil.ReadDir("./")
    for _, f := range files {
        if f.IsDir() {
            fu(f.Name(), params)
        }
    }
}

func (t T1) traverse(fu func(string)) {
    files, _ := ioutil.ReadDir("./")
    for _, f := range files {
        if f.IsDir() {
            repoDir := filepath.Join(getExPath(), f.Name())
            status := run(repoDir, "git", "status")
            if !(status == "" || strings.Contains(status, "fatal:")) {
                fu(f.Name())
            }
        }
    }
}

func (t T2) traverse(fu func(string, string), parms string) {
    files, _ := ioutil.ReadDir("./")
    for _, f := range files {
        if f.IsDir() {
            repoDir := filepath.Join(getExPath(), f.Name())
            status := run(repoDir, "git", "status")
            if !(status == "" || strings.Contains(status, "fatal:")) {
                fu(f.Name(), parms)
            }
        }
    }
}

func (t T3) traverse(fu func(string, string, string), search string, diff string) {
    files, _ := ioutil.ReadDir("./")
    for _, f := range files {
        if f.IsDir() {
            repoDir := filepath.Join(getExPath(), f.Name())
            status := run(repoDir, "git", "status")
            if !(status == "" || strings.Contains(status, "fatal:")) {
                fu(f.Name(), search, diff)
            }
        }
    }
}

var all = []string{"-a", "a", "--all"}
var local = []string{"-a", "a", "--all"}

func runForSingleRepo(params string) bool {
    return isGit(getExPath()) && !in(params, all)
}

func main() {
    if len(os.Args) < 2 {
        help()
        return
    }
    // actions "help" "log" "diff"
    action := os.Args[1]
    if action == "help" {
        help()
        return
    }
    var attr = ""
    if len(os.Args) > 2 {
        attr = os.Args[2]
    }
    var params = ""
    if len(os.Args) > 3 {
        params = os.Args[3]
    }
    switch action {
    case "log":
        search := attr
        if runForSingleRepo(params) {
            fmt.Printf(getExPath())
            gitGrep(getExPath(), search, "false")
        } else {
            T3{}.traverse(gitGrep, search, "false")
            affected()
        }
    case "diff":
        search := attr
        if runForSingleRepo(params) {
            gitGrep(getExPath(), search, "true")
        } else {
            T3{}.traverse(gitGrep, search, "true")
            affected()
        }
    case "branch":
        params := attr
        T2{}.traverse(branch, params)
    case "checkout":
        // search - is branch name
        branch := attr
        T3{}.traverse(checkout, params, branch)
    case "pull":
        T1{}.traverse(pull)
    case "status":
        if runForSingleRepo(params) {
            status(getExPath())
        } else {
            T1{}.traverse(status)
            affected()
        }
    case "fix-upstream":
        if runForSingleRepo(params) {
            fixUpstream(getExPath())
        } else {
            T1{}.traverse(fixUpstream)
        }
    case "last":
        if runForSingleRepo(params) {
            fmt.Print(run(getExPath(), "git", "log", "-1"))
        } else {
            T1{}.traverse(getLastCommits)
            sortLastCommits()
        }
    case "work":
        if runForSingleRepo(params) {
            getWorkHistory(getExPath())
        } else {
            T1{}.traverse(getWorkHistory)
            sortLastCommits()
        }
    case "mvn":
        setMavenOptions()
        if runForSingleRepo(params) {
            fmt.Print(run(getExPath(), "mvn", os.Args[2:]...))
        } else {
            countMvnDirs()
            TN{}.traverse(mvn, os.Args[2:])
        }
    }
}
