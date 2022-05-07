import Foundation
import AVFoundation
import ColorizeSwift

class AudioPlayer {
    var filePath: String
    var audioFile: AVAudioFile?
    var audioEngine: AVAudioEngine = AVAudioEngine()
    var playerNode: AVAudioPlayerNode = AVAudioPlayerNode()

    init(filePath: String) {
        self.filePath = filePath
        let fileURL = URL(fileURLWithPath: filePath)
        print("File URL: \(fileURL)")
        do {
            self.audioFile = try? AVAudioFile(forReading: fileURL)
        }
    }

    func setupPlayer() {
        self.audioEngine.attach(self.playerNode)
        self.audioEngine.connect(self.playerNode, to: self.audioEngine.outputNode, format: self.audioFile!.processingFormat)
        self.playerNode.scheduleFile(self.audioFile!, at: nil, completionCallbackType: .dataPlayedBack)
    }

    func play() {
        print("Playing \(self.filePath.green())...")
        // print(self.audioEngine.attachedNodes)
        
        do {
            self.audioEngine.prepare()
            try self.audioEngine.start()
            self.playerNode.play()
        } catch {
            print("Error while playing: \(error)")
            self.playerNode.stop()
            self.audioEngine.stop()
        }
    }
}