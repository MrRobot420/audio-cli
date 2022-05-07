import Foundation
import ArgumentParser
import AVFoundation
import ColorizeSwift

struct AudioCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to stream audio files to multiple outputs.".blue(),
        version: "0.0.1",
        subcommands: [Play.self, Discover.self])

    init() { }
}

struct Play: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Play given audio file on given audio device.".blue())

    @Argument(help: "The audio file path.")
    private var filePath: String

    func run() throws {
        print("Playing audio for file \"\(filePath.green())\"")
        let audioPlayer = AudioPlayer(filePath: filePath)
        audioPlayer.play()
    }
}

struct Discover: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Discover audio devices.".blue())

    func run() throws {
        print("Discovering audio devices...\n")
        let devices = AudioDeviceFinder.findDevices()
        print("\n✅ Found \(devices.count) audio devices.")
    }
}

AudioCLI.main()