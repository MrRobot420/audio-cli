import Foundation
import AVFoundation
import ColorizeSwift

class AudioPlayer {
    var fileName: String
    var fileURL: URL
    var audioFile: AVAudioFile?
    var audioEngine: AVAudioEngine = AVAudioEngine()
    var playerNode: AVAudioPlayerNode = AVAudioPlayerNode()
    var deviceID: AudioDeviceID
    

    init(filePath: String, deviceName: String) {
        self.fileName = filePath
        self.fileURL = URL(fileURLWithPath: filePath)
        self.deviceID = AudioDeviceFinder.getDeviceID(device: deviceName)
        
        do {
            self.audioFile = try? AVAudioFile(forReading: self.fileURL)
        }
    }

    func attachToDevice() {
        let output = self.audioEngine.outputNode
        let outputUnit = output.audioUnit! // get the low level input audio unit from the engine
        var outputDeviceID: AudioDeviceID = self.deviceID // use core audio low level call to set the input device:
        
        AudioUnitSetProperty(outputUnit,
                             kAudioOutputUnitProperty_CurrentDevice,
                             kAudioUnitScope_Global,
                             0,
                             &outputDeviceID,
                             UInt32(MemoryLayout<AudioDeviceID>.size))
    }
    
    func setupPlayer() {
        self.attachToDevice() // set audio-output to the initialised deviceID
        self.audioEngine.attach(self.playerNode)
        self.audioEngine.connect(self.playerNode, to: self.audioEngine.outputNode, format: self.audioFile!.processingFormat)
        self.playerNode.scheduleFile(self.audioFile!, at: nil, completionCallbackType: .dataPlayedBack, completionHandler: {(completionType) in
            print("done")
            exit(-1)
        })
    }

    func play() {
        print("\n▶️ Playing \(self.fileName.green())... | from:", "\(self.fileURL)".red())
        
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
