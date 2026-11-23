# NOCTURNE 0.3 — Xcode scheme and build-workflow repair

NOCTURNE is an iOS SwiftUI interface for device notes and high-level vulnerability documentation.

## What caused the screenshot error

The previous workflow called `xcodebuild` with `-target Nocturne` while also passing `-derivedDataPath`. Xcode 26.6 rejected that combination with exit code 64 because this build invocation requires a scheme (or a test-specific alternative). The Xcode installation itself was detected correctly.

## What changed in 0.3

- Added a **shared** scheme at `Nocturne.xcodeproj/xcshareddata/xcschemes/Nocturne.xcscheme` so GitHub's clean checkout can discover `Nocturne`.
- Replaced target-based invocation with `-scheme Nocturne`.
- Added an explicit generic iOS device destination and Release configuration.
- Kept DerivedData in the runner's temporary directory and disabled code signing for the build step.
- Added pre-build checks and Xcode project/scheme listing.
- Added IPA structure checks before upload.
- Preserved the compiler log and Xcode result bundle as failure diagnostics.
- Updated the in-app version label to 0.3.

## Run it

1. Extract this ZIP.
2. Upload the **contents** of the extracted folder to the root of your GitHub repository. Keep the `.github` folder and the entire `Nocturne.xcodeproj` folder structure.
3. Open **Actions** in the GitHub repository.
4. Select **Build NOCTURNE unsigned IPA**.
5. Choose **Run workflow** and start it.
6. If successful, download the `Nocturne-unsigned-ipa` artifact from that run.
7. If it fails, download `Nocturne-build-diagnostics` and share the first compiler `error:` lines or the log. Do not share credentials or signing keys.

## Verification status

Static checks can verify project-file syntax, scheme XML, Swift source parsing, workflow shell syntax, and ZIP integrity. This environment does not include Apple's Xcode/iOS SDK, so it cannot run the actual iOS compile. The GitHub Actions run is the final build verification; no honest process can promise zero errors before that run executes on Apple's toolchain.

The produced IPA is **unsigned**. Installing it requires a valid Apple signing identity and provisioning profile.

## Scope

This is a documentation and interface project. The supplied kernel proof-of-concepts are not embedded, compiled, or executed. The ANE dossier is documentation-only and records that its source archive was not revalidated in this update. NOCTURNE does not access kernel memory, implement privilege escalation, persist on a device, or bypass device security.

## NOCTURNE 0.5 research archive update

This package adds source-grounded research records for:
- AppleAVE2 / CVE-2026-112705 (based on the uploaded archive README).
- Apple Neural Engine references CVE-2026-84494 and CVE-2026-112696 (based on comments in the uploaded source files).
- The supplied decompressed kernel image's Mach-O type, architecture, embedded Darwin/XNU strings, and SHA-256.

The uploaded AVE and ANE trigger/exploitation source is not copied into the app, compiled, or run. The raw panic logs are not bundled. The 64 MiB Apple kernel binary is not redistributed in the app package; its identity and hash are recorded instead. These records do not establish a working jailbreak.
