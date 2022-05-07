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
##### Output:
```
Discovering audio devices...

Found device "BN650Y", uid=AppleGFXHDAEngineOutputDP:30001:0:{6D1E-5BA5-0003A487}
Found device "BN650Y", uid=AppleGFXHDAEngineOutputDP:30001:1:{6D1E-5BA5-0003A486}
Found device "BlackHole 2ch", uid=BlackHole2ch_UID
Found device "MacBook Pro-Lautsprecher", uid=BuiltInSpeakerDevice
Found device "Multiausgangsgerät", uid=~:AMS2_StackedOutput:0

✅ Found 5 audio devices.
```

#### Playing audio files:
```bash
swift run audio-cli play <filename>
```
--> The filename does *not* have to be the absolute path.

##### Output:
```
[0/0] Build complete!
Playing audio for file "audio/someone.mp3"
File URL: audio/someone.mp3 -- file:///Users/max/code/swift/audio-cli/
Playing audio/someone.mp3...
```

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