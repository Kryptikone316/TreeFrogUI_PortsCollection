# FroggyMania port build

`build.sh` builds the bundled Sonic Mania libretro frontend into
`froggymania_libretro.so`. It fetches RSDKv5 at
`191d7aea6c262d891244172a8609ac69fbfd7571` and libretro-deps at
`7e6e34f0319f4c7448d72f0e949e76265ccf55a1`, applies the adapter patches in
`source/treefrogui`, and statically compiles the Ogg and Theora decoder sources.

The resulting ELF uses the TreeFrogUI MIPS32r2 little-endian hard-float ABI
(`-march=mips32r2 -mhard-float`). It is not the upstream SF2000/GB300
soft-float firmware binary. Device launch and display layout are verified on
R36SX. Audio still needs verification.

TreeFrogUI build skips RSDK video cutscenes because its framebuffer backend
does not render YUV video textures. Game audio output remains unverified.

From this directory, run:

```sh
./build.sh
```

The default cross compiler names are `mips-mti-linux-gnu-gcc`,
`mips-mti-linux-gnu-g++`, and `mips-mti-linux-gnu-gcc-ar`. Override them with
`CC`, `CXX`, and `AR` if needed. The script fetches its pinned dependencies into
a temporary directory and does not rely on a TreeFrogUI checkout.
