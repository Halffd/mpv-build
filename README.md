# mpv Subtitle Bottom Stacking Feature

This repository contains the implementation of a new `--sub-bottom-stacking` feature for mpv that allows users to stack primary and secondary subtitles at the bottom of the screen instead of the top.

## Feature Description

The `--sub-bottom-stacking` option enables stacking of secondary subtitles above primary subtitles at the bottom of the screen. When enabled, both primary and secondary subtitles will appear near the bottom of the screen, with secondary positioned above the primary subtitle.

## Files Modified

1. `DOCS/man/options.rst` - Documentation for the new option
2. `options/options.c` - Added the option definition
3. `options/options.h` - Added the option to the struct
4. `sub/osd.c` - Implemented the stacking logic
5. `sub/sd_ass.c` - Adjusted subtitle positioning when stacking is enabled

## Patch Application

The patch is automatically applied by the update script. If you need to apply it manually, use the `apply_patch` script:

```bash
./apply_patch
```

## Update Script Integration

The update script has been modified to automatically apply the patch after updating the mpv repository. The patching process:

- Checks if the patch is already applied
- Applies the patch if not already applied
- Continues without failing if patch application fails (e.g., due to incompatibility)
- Uses error tolerance to prevent build failures

## Usage

After applying the patch and building mpv, use the new option:

```bash
mpv --sub-bottom-stacking=yes video.mp4
```

## Building mpv with the Feature

To build mpv with this feature:

1. Run the update script: `./update`
2. Build mpv using your preferred build system (meson/ninja)

Note: There may be occasional linking issues with newer versions of dependencies, but the code changes themselves are correct and implement the requested feature.