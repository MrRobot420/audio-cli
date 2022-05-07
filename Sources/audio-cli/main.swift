import Foundation
import ArgumentParser
import AVFoundation

struct AudioCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to stream audio files to multiple outputs.",
        version: "0.0.1",
        subcommands: [Play.self, Discover.self])

    init() { }
}

struct Play: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Play given audio file on given audio device.")

    @Argument(help: "The audio file path.")
    private var filePath: String

    @Argument(help: "The audio output device UID.")
    private var deviceUID: String?

    func run() throws {
        print("Creating outputs on device \"\(deviceUID ?? "no device")\" for file \"\(filePath)\"")
    }
}

struct Discover: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Discover audio devices.")

    func run() throws {
        print("Discovering audio devices...")
        let devices = AudioDeviceFinder.findDevices()
        print("\n✅ Found \(devices.count) audio devices.")
    }
}

AudioCLI.main()