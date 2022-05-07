import Foundation
import AVFoundation
import ColorizeSwift

class AudioPlayer {
    var filePath: String
    var player: AVAudioPlayer = AVAudioPlayer()

    init(filePath: String) {
        self.filePath = filePath
        let fileURL = URL(fileURLWithPath: filePath)
        print("File URL: \(fileURL)")
        self.player = try! AVAudioPlayer(contentsOf: fileURL, fileTypeHint: AVFileType.mp3.rawValue)
        self.player.numberOfLoops = 1 // loop count, set -1 for infinite
        self.player.volume = 1.0
        self.player.prepareToPlay()
    }

    func play() {
        print("Playing \(self.filePath.green())...")
        self.player.play()
    }
}