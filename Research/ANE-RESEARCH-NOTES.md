# Apple Neural Engine research record

## Source
User-supplied archive: `ane_ane_ane.zip`
SHA-256: `fd73549f09b09f3157a957dbd1b2f721260f34d6d3969916f06e400fd42900bc`

## Files actually present
- `ane_ane_ane/ane_probe.c`
- `ane_ane_ane/ane_probe.h`
- `ane_ane_ane/ane_overflow.m`
- `ane_ane_ane/ane_overflow.h`
- Two `__MACOSX` metadata sidecars

No README or independent evidence report was present in this ZIP.

## What the source comments claim
- The headers reference CVE-2026-84494 and CVE-2026-112696.
- The source comments describe Apple Neural Engine service probing and an overflow proof of concept.
- The comments describe a kernel-memory-corruption / heap-corruption research path.

These are source-code comments and author claims. They do not independently establish CVE assignment, affected firmware, exploitability, or a working jailbreak.

## Safety and integration decision
The source contains overflow-trigger and exploitation interfaces. NOCTURNE 0.5 does not copy, compile, execute, or integrate those routines. This dossier is documentation-only.
