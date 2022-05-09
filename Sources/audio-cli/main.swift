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

    @Option(name: .short, help: "The output device uid.")
    private var device: String

    @Argument(help: "The audio file path.")
    private var filePath: String

    func run() throws {
        let player = AudioPlayer(filePath: filePath, deviceName: device)

        player.setupPlayer()
        player.play()
        
        while(true){
            readLine()
        }
    }
}

struct Discover: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Discover audio devices.".blue())

    func run() throws {
        let devices = AudioDeviceFinder.findDevices()
        print("\n✅ Found \(devices.count) audio devices.")
    }
}

AudioCLI.main()
