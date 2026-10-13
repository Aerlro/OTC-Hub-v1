# OTC Hub v1.0.4 changes

- Reworked the default window into a compact 500×300 floating layout inspired by the supplied video.
- Changed the header, sidebar and content geometry for compact navigation.
- Replaced Search, Minimize and Close text glyphs with the supplied image assets.
- Updated the Default theme to slate/blue-grey with cyan accents and subtle transparency.
- Fixed the theme-list sort comparator for equal names.
- Normalized non-positive slider increments to 1.
- Made LoadConfig return false for missing configs and replace old flags on successful load.
- Tracked and disconnected drag/input connections when unloading a window.
- Added root latest loader and fixed-version v1.0.4 loader, plus an immutable versions/1.0.4 snapshot.
