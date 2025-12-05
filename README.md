# subfix

## Description

Desktop application for adjusting subtitle timing (.srt, .sub and .ass). Shift subtitles forward or backward with a simple interface.

All processing is done locally. No files are uploaded.


## Features

- Supports .srt, .sub and .ass formats.
- Shift subtitles forward or backward by any offset.
- Simple and minimal UI.
- Detects UTF-8 encoding and converts when needed.


## Requirements

- Flutter 3.35.7 or later (stable)


## Installation

Clone the repository and run the app with Flutter:

```bash
git clone https://github.com/ifgar/subfix.git
cd subfix
flutter pub get
flutter run
```


## Usage

1. Select a subtitle file (.srt, .sub or .ass).
2. Enter the desired offset (positive or negative).
3. Apply the shift to generate the adjusted subtitle file.

The adjusted file is saved next to the original using the pattern `name[OFFSET].ext` (for example: `movie[1.5].ass`).

Currently tested on Linux. Other desktop platforms may work but are not officially supported yet.


## Screenshots

_TBA_


## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
