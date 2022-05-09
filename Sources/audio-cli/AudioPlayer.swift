import Foundation
import AVFoundation
import ColorizeSwift

class AudioPlayer {
    var filePath: String
    var audioFile: AVAudioFile?
    var audioEngine: AVAudioEngine = AVAudioEngine()
    var playerNode: AVAudioPlayerNode = AVAudioPlayerNode()
    var deviceID: AudioDeviceID
    

    init(filePath: String, deviceName: String) {
        self.filePath = filePath
        self.deviceID = AudioDeviceFinder.getDeviceID(device: deviceName)
        let fileURL = URL(fileURLWithPath: filePath)
        print("File URL: \(fileURL)")
        do {
            self.audioFile = try? AVAudioFile(forReading: fileURL)
        }
        let output = audioEngine.outputNode
        // get the low level input audio unit from the engine:
        let outputUnit = output.audioUnit!
        // use core audio low level call to set the input device:
        var outputDeviceID: AudioDeviceID = self.deviceID
        AudioUnitSetProperty(outputUnit,
                             kAudioOutputUnitProperty_CurrentDevice,
                             kAudioUnitScope_Global,
                             0,
                             &outputDeviceID,
                             UInt32(MemoryLayout<AudioDeviceID>.size))
    }
    
    func setupPlayer() {
        self.audioEngine.attach(self.playerNode)
        self.audioEngine.connect(self.playerNode, to: self.audioEngine.outputNode, format: self.audioFile!.processingFormat)
        self.playerNode.scheduleFile(self.audioFile!, at: nil, completionCallbackType: .dataPlayedBack, completionHandler: {(completionType) in
            print("done")
            exit(-1)
        })
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
