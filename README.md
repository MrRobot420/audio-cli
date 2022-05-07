# Swift audio-cli

## What is it?
A command line tool for:
- discovering audio devices
- playing audio files by file-path

## Usage (during development)

#### Help / Show options:
```bash
swift run audio-cli -h
```

##### Output:
```
[0/0] Build complete!
OVERVIEW: A Swift command-line tool to stream audio files to multiple outputs.

USAGE: audio-cli <subcommand>

OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.

SUBCOMMANDS:
  play                    Play given audio file on given audio device.
  discover                Discover audio devices.

  See 'audio-cli help <subcommand>' for detailed help.
```

#### Discover audio devices:
```bash
swift run audio-cli discover
```

#### Playing audio files:
```bash
swift run audio-cli play <filename>
```
--> The filename does *not* have to be the absolute path.

---

## Release Library (for production)
### Release the library

```bash
swift build --configuration release
```

### Copy the library to /user/local/bin
```bash
cp -f .build/release/audio-cli /usr/local/bin/audio-cli
```

---

## Usage after installation

#### Help / Show options:
```bash
audio-cli -h
```

#### Discover audio devices:
```bash
audio-cli discover
```

#### Play audio file:
```bash
audio-cli play <filename>
```