## Snyk Backend Scan — Analysis

Path: `golang-gin-realworld-example-app`

Date scanned: 2025-11-30

Summary
- **Total vulnerabilities found:** 3
- **Severity breakdown:** High: 3

Top findings

1) Access Restriction Bypass in `github.com/dgrijalva/jwt-go`
- **Severity:** High (CVSS 7.5)
- **Identifiers:** CVE-2020-26160, GHSA-w73w-5m7g-f7qc
- **Description:** Audience (`aud`) type assertion can fail when the token contains an empty `[]string{}`, allowing audience verification to succeed incorrectly and potentially bypass access restrictions.
- **Affected version(s) observed:** `github.com/dgrijalva/jwt-go@3.2.0` (found twice in report — two vulnerable usages)
- **Remediation:** Replace or upgrade the dependency. `dgrijalva/jwt-go` is unmaintained in many projects — recommended options:
  - Replace with the maintained fork `github.com/golang-jwt/jwt/v4` and update imports accordingly.
  - If a direct upgrade to `github.com/dgrijalva/jwt-go@4.0.0-preview1` is acceptable/tested, upgrade to that version (however the maintained fork is preferred).
  - After change, run `go mod tidy`, rebuild and run tests.

2) Heap-based Buffer Overflow in `github.com/mattn/go-sqlite3`
- **Severity:** High
- **Description:** Native buffer overflow issue in `go-sqlite3` versions `<1.14.18` which can allow memory corruption.
- **Affected version observed:** (report shows a vulnerable version in dependency graph)
- **Remediation:** Upgrade to `github.com/mattn/go-sqlite3@v1.14.18` or later.

Dependency analysis
- The vulnerabilities are present in direct or transitive dependencies used by the backend module (`realworld-backend`).
- In particular `github.com/dgrijalva/jwt-go@3.2.0` is referenced; `snyk` indicates it is not upgradable in-place (`isUpgradable: false`). That suggests either replacing the dependency with maintained fork or refactoring imports.

Recommended immediate remediation plan (short):
1. Replace `github.com/dgrijalva/jwt-go` with `github.com/golang-jwt/jwt/v4`:

```bash
cd golang-gin-realworld-example-app
go get github.com/golang-jwt/jwt/v4@latest
go mod tidy
# update import paths in code from github.com/dgrijalva/jwt-go to github.com/golang-jwt/jwt/v4
```

2. Upgrade sqlite3 binding:

```bash
go get github.com/mattn/go-sqlite3@v1.14.18
go mod tidy
```

3. Run tests and build the backend to ensure no breaking changes:

```bash
go test ./...
go build ./...
```

4. Re-run Snyk test and save new report:

```bash
snyk test --json > snyk-backend-report-after-fixes.json
```

Notes on screenshots for the report
- For the Snyk deliverables you should capture the following screenshots after you push the project to Snyk (or after `snyk monitor`):
  - Snyk project dashboard (overall vulnerability counts)
  - The detailed issue page for `github.com/dgrijalva/jwt-go` (showing CVE and remediation guidance)
  - The detailed issue page for `github.com/mattn/go-sqlite3`

I can implement the dependency changes and attempt a local build/test if you want — this will require updating imports in Go source files (search/replace `github.com/dgrijalva/jwt-go` -> `github.com/golang-jwt/jwt/v4`).

Next steps I will take if you confirm:
- (A) Apply the `jwt` replacement and `go-sqlite3` upgrade, run `go test` and `go build`.
- (B) Re-run `snyk test` and produce `snyk-backend-report-after-fixes.json` and an updated analysis `snyk-fixes-applied.md` with before/after results.

If you prefer to run the code changes yourself, I will instead continue with the frontend Snyk scans and prepare the SonarQube steps.

Status update (completed actions)
- **Actions performed:** Replaced `github.com/dgrijalva/jwt-go` with `github.com/golang-jwt/jwt/v4` in the code (updated `users/middlewares.go` and `common/utils.go`), removed a generated `go.mod` file that referenced the deprecated package, upgraded `github.com/mattn/go-sqlite3` to `v1.14.18`, and ran `go mod tidy`.
- **Results:** Local `go test` and `go build` succeeded. Re-running `snyk test` reports no known vulnerabilities (`uniqueCount: 0`, `ok: true`). The updated Snyk JSON report is saved as `golang-gin-realworld-example-app/snyk-backend-report-after-fixes2.json`.

If you want, I can now:
- Commit these changes and push them (you'll need to confirm commit message and remote).
- Run the frontend Snyk scans and set up SonarQube + ZAP as the next steps for Assignment 2.
