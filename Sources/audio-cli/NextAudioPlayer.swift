import Foundation
import AVFoundation

class NextAudioPlayer {
    var filePath: String
    var group: DispatchGroup
    var testAudio: AVAudioPlayer
    var url: URL

    init(filePath: String) {
        self.filePath = filePath
        self.testAudio = AVAudioPlayer()
        self.group = DispatchGroup()
        self.group.enter()
        self.url = URL(fileURLWithPath: self.filePath)
    }

    func setupQueue() {
        print("Setting up queue...")
        DispatchQueue.main.async {
            do {
                self.testAudio = try AVAudioPlayer(contentsOf: self.url)
                self.testAudio.prepareToPlay()
            } catch let err {
                print("Failed play audio: \(err)")
            }
            self.group.leave()
        }
    }

    func play() {
        print("Playing \(self.filePath.green())...")
        self.group.notify(queue: .main) {
            print("play audio")
            self.testAudio.play()
        }
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            print("stop audio")
        }
    }
}