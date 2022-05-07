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
    public static let configuration = CommandConfiguration(abstract: "Play multiple audio outputs from the given audio file-path.")

    @Argument(help: "The audio file path.")
    private var filePath: String

    func run() throws {
        print("Creating outputs for file \"\(filePath)\"")
    }
}

struct Discover: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Discover audio devices.")

    func run() throws {
        print("Discovering audio devices...")
        let devices = AudioDeviceFinder.findDevices()
        print("Found \(devices.count) audio devices:")
        for device in devices {
            print("\t\(device.name ?? "Unknown") (\(device.uid ?? "Unknown"))")
        }
    }
}

AudioCLI.main()