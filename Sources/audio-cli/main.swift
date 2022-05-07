import ArgumentParser

struct AudioCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to stream audio files to multiple outputs.",
        version: "0.1.0",
        subcommands: [Generate.self])

    init() { }
}

struct Generate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generate multiple audio outputs from the given audio file-path.")

    @Argument(help: "The audio file path.")
    private var filePath: String

    func run() throws {
        print("Creating outputs for file \"\(filePath)\"")
    }
}

AudioCLI.main()