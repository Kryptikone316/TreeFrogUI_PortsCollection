# Diablo 1 (DevilutionX)

This integration is packaged from [FroggyDiablo](https://github.com/tzubertowski/FroggyDiablo),
based on the original [DevilutionX project](https://github.com/diasurgical/DevilutionX).

TreeFrogUI launches the standalone DevilutionX port from **Games → Ports →
Diablo 1**.

This package does not include Blizzard's copyrighted game data. Copy the
`DIABDAT.MPQ` file from your legally owned Diablo 1/GOG installation into:

```text
/roms/ports/diablo/DIABDAT.MPQ
```

The hidden port data folder includes the open-source `devilutionx.mpq` engine
asset. Select **Diablo 1** in the Ports root after copying `DIABDAT.MPQ`;
the launcher sets the working directory so DevilutionX finds its data and saves.

The SF3000 test build is based on the C++17-compatible DevilutionX revision
used by the device's GCC 6.3 toolchain.
