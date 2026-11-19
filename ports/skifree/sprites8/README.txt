8-bit sprite pack (optional)
============================

Used when the launcher theme is "8-bit" (L1/R1 on the menu). Made from the 16-bit pack by tools/make_sprites8.py:
every sprite is reduced to half resolution (2x2-pixel blocks, same size as the original so collisions do not change)
and snapped to one fixed 36-colour palette. Sprites with small lettering (signs, OUCH!, WOOF!) keep their 16-bit
drawing and are only snapped to the palette. Files missing here fall back to sprites16/, then to the game's own art.
