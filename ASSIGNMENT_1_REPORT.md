# Assignment 1: Backend Implementation & Tests

---

## Introduction

This report documents the work completed for Assignment 1 of the SWE302 course. The objective of the assignment was to execute the backend test suite of a provided Gin/GORM RealWorld application, identify and resolve compilation and runtime test failures, and present verifiable evidence of successful test execution.

## Objectives

The objectives of this assignment were to:
- Execute the complete backend test suite.
- Identify and fix validation, test, and database-related errors.
- Achieve a clean test run with all packages compiling and passing.
- Document fixes, results, and supporting evidence clearly.

## Environment
The assignment was completed using the following environment:
- Operating System: macOS
- Shell: zsh
- Programming Language: Go
- Frameworks: Gin, GORM
- Repository: golang-gin-realworld-example-app

## Methodology
The work was carried out iteratively using a test–debug–fix cycle. The full test suite was run to identify errors, failing packages were inspected, and minimal targeted fixes were applied. After each change, tests were re-executed to confirm correctness. This process continued until all backend tests passed successfully.

Care was taken to keep changes focused and minimal to avoid introducing unintended behavior.

## Changes Made 

The following changes were applied to achieve a stable and passing test suite:

- **Validation logic**

The update request validation in users/validators.go was corrected so that only fields provided in the request are validated. This aligned the validator behavior with expected partial-update semantics.

- **Unit tests**

Build errors in users/unit_test.go were fixed by correcting malformed imports, resolving struct literal issues, and removing references to an unregistered custom validation tag (exists) that caused runtime panics.

- **Test harness and database setup**

An AutoMigrate call in common/unit_test.go was removed, as it created an invalid empty table and resulted in SQL syntax errors during test execution.

- **Repository hygiene**

The local test database file (gorm_test.db) was added to .gitignore, and the untracked file was removed to maintain a clean repository state.

## Results

After applying the fixes, the backend compiled successfully and all tests passed:
- The full test suite (go test ./...) completed without failures.

- The users package tests executed successfully and produced expected database schema and index logs.

- Test outputs and screenshots were saved as evidence and included in the repository.

## Screenshots and Evidence

![Figure 1 — full test run showing final PASS/ok lines and SQL logs](images/assign1/1.png)
*Figure 1: Full backend test run showing passing results and SQL logs

![Figure 2 — focused git status output showing tracked/untracked files](images/assign1/2.png)
*Figure 2: Git repository status showing modified and untracked files

![Figure 3 — git diff output showing staged/unstaged changes](images/assign1/3.png)
*Figure 3: Git diff highlighting changes applied to the source and test files

![Figure 4 — users unit test head showing `unauthRequestTests` placeholder](images/assign1/4.png)
*Figure 4: users/unit_test.go showing corrected imports and test adjustments

![Figure 5 — users validators file showing update validation logic](images/assign1/5.png)
*Figure 5: users/validators.go showing updated validation logic

2. Save users package output with DB logs:

```bash
go test ./users -v | tee users_test_output.txt
```

Screenshot the terminal showing the SQL statements (CREATE TABLE, CREATE INDEX lines).

3. Show git diffs:

```bash
git status --porcelain
git --no-pager diff --staged || git --no-pager diff
```

![Figure 3 — git status and diff output showing untracked/changed files](images/assign1/3.png)

4. Open key files in your editor and screenshot their tabs and content:

 - `users/unit_test.go`
 - `users/validators.go`

Optionally: run an example API request against the app if you start it locally and capture the HTTP response.

## Conclusion

This assignment involved running, debugging, and stabilizing the backend test suite of a Gin/GORM-based Go application. I systematically executed the full test suite, investigated failing tests, and applied minimal, targeted fixes to validation logic, unit tests, and the test database setup until all tests compiled and passed successfully. Test outputs, database logs, and screenshots were captured and included as reproducible evidence.

Through this work, I learned how backend tests interact with application logic, validators, and the database layer in a real-world Go project. I gained practical experience in reading Go test failures, fixing struct and import issues, handling custom validators, and diagnosing database-related errors caused by test harness configuration. The assignment also reinforced the importance of repository hygiene, reproducible testing, and documenting changes clearly with evidence.

Overall, this assignment improved my confidence in debugging backend systems, understanding test-driven development workflows in Go, and maintaining a clean, verifiable project state suitable for submission or further development.

## Deliverables
The following files are included in the submission:
- ASSIGNMENT_1_REPORT.md
- golang-gin-realworld-example-app/test_output.txt
- golang-gin-realworld-example-app/users_test_output.txt
- images/assign1/ (screenshots)
