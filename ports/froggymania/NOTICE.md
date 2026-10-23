# FroggyMania notices

FroggyMania adapts [Synaps33/FroggyMania](https://github.com/Synaps33/FroggyMania),
which contains the Sonic Mania decompilation and the SF2000/GB300 frontend.
The upstream source is included as a pinned submodule. Its
`source/sonicmania-sf2000/LICENSE.md` is copied in `licenses/` and applies to
the decompilation and this port's modifications. The RSDKv5 decompilation
license is also included in `licenses/`.

The build statically includes libogg and libtheora decoder code from the pinned
`libretro/libretro-deps` revision. Their license texts are included in
`licenses/`.

Sonic Mania and all game art, music, and other game data remain the property of
their respective rights holders. The required `Data.rsdk` must come from the
user's own Sonic Mania Plus PC installation. No game data is included here.
