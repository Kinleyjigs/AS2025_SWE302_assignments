## Snyk Frontend Scan — Analysis

Path: `react-redux-realworld-example-app`

Date scanned: 2025-11-30

Summary
- **Initial vulnerable dependency paths:** 6 (critical + medium findings)
- **Actions taken:** Upgraded `marked` to `^4.0.10` (resolves multiple ReDoS findings). Attempted to upgrade `superagent` to `^10.2.2`, but that caused the frontend build to fail due to incompatibility with the old `react-scripts` used in this project. Reverted `superagent` back to `^3.8.2` to restore a successful build.
- **Current Snyk status:** 1 vulnerable dependency path remains (critical): `form-data@2.3.3` via `superagent@3.8.3` — saved report: `snyk-frontend-report-after-fixes.json`.

Details
- Vulnerabilities addressed:
  - `marked` ReDoS issues — upgraded to `4.0.10`.
- Remaining high/critical issue:
  - `form-data@2.3.3` (Predictable Value Range) — Snyk identifies this via the `superagent@3.8.3` dependency. Snyk's suggested upgrade path is to upgrade `superagent` to `10.2.2` (which uses `form-data@4.0.5`).

Why `superagent` upgrade wasn't applied automatically
- This frontend uses very old `react-scripts` (`react-scripts` v1.x) and other aged tooling that cannot minify or compile some modern JS in recent `superagent` major releases (ES6+ syntax). Upgrading `superagent` to v10 requires modernizing the build tooling (e.g., upgrade `react-scripts` to v4+ or migrate to newer React toolchain), which is out-of-scope for a minimal Snyk remediation and risks breaking the sample app.

Recommended remediation options (choose one)
1. Full upgrade (best security posture):
   - Upgrade the app toolchain (`react-scripts`, Node, etc.) to support modern dependencies, then bump `superagent` to `^10.2.2` and re-run `npm install`.
   - Commands (example):
     ```bash
     cd react-redux-realworld-example-app
     npm install react-scripts@5.0.1 --save-dev
     npm install superagent@^10.2.2
     npm install
     npm run build
     snyk test --json > ../snyk-frontend-report-after-fixes-2.json
     ```
2. Targeted dependency override (lower risk, limited effect):
   - Add a top-level `form-data@^4.0.5` dependency to attempt to satisfy the tree, then `npm install` and re-run Snyk. This may not fully remove the nested vulnerable copy if `superagent` pins a specific semver range.
   - Commands:
     ```bash
     cd react-redux-realworld-example-app
     npm install form-data@^4.0.5
     npm install
     snyk test --json > ../snyk-frontend-report-after-fixes-2.json
     ```
3. Compensating control / monitor: If upgrading the toolchain is not possible within the assignment timeframe, document the remaining risk, add a Snyk ignore/patch with justification or monitor for exploit activity, and include the remediation plan in the final report.

Files created/updated
- `snyk-frontend-report.json` (initial scan)
- `snyk-code-report.json` (Snyk Code SARIF output)
- `snyk-frontend-report-after-fixes.json` (post-change scan)
- `react-redux-realworld-example-app/package.json` (updated `marked` and temporarily reverted `superagent`)

Next steps I can take (pick one):
- I can attempt the full toolchain + `superagent` upgrade now (I will run the commands and report build/test results). This may require more work to fix breaking changes.
- I can try the targeted `form-data` override as a lower-risk attempt.
- I can document the remaining risk and move on to SonarQube/ZAP steps.

---

Saved Snyk report: `snyk-frontend-report-after-fixes.json`
