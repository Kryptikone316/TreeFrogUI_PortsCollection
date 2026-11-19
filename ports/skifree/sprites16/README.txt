16-bit sprite pack (optional)
=============================

Used when the launcher theme is "16-bit" (L1/R1 on the menu). Each file replaces one of the game's sprites:
ski32_<number>.bmp, 24-bit BMP, drawn for this port. Any sprite without a file here keeps the game's own look.

A file is only used when its width and height equal the original sprite's, because the sprite sizes are what the
game uses for collisions. Pure white (255,255,255) is the game's "transparent" colour, so never use it inside art.
