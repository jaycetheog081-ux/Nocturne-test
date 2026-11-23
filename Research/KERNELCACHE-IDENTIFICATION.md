# Kernel image identification record

## Supplied file
`kernelcache.decompressed.bin`

- Size: 67,108,864 bytes
- SHA-256: `742714192f267bf7fbfe3de8c5437b534d7f305bf87c8b77c4d1ad9dd7446385`
- Container format: Mach-O 64-bit ARM64e, file type `MH_FILESET` (type 12)
- Embedded version string: `Darwin Kernel Version 27.0.0`
- XNU string: `xnu-13432.2.10~2`
- Build configuration string: `RELEASE_ARM64_T8110`

## Interpretation
These values identify strings embedded in the supplied binary. They do not prove which exact iOS marketing version or device supplied it, and do not establish that any vulnerability applies to it.

## Packaging decision
The 64 MiB Apple kernel binary is not copied into the app bundle. NOCTURNE stores this identification record and hash so the artifact can be matched without redistributing a proprietary operating-system binary.
