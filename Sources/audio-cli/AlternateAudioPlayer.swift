import Foundation
import AppKit
import AudioToolbox
import AVFoundation

struct readFile {
    static var arrayFloatValues:[Float] = []
    static var points:[CGFloat] = []
}

let audioEngine: AVAudioEngine = AVAudioEngine()
let audioPlayer: AVAudioPlayerNode = AVAudioPlayerNode()

class AlternateAudioPlayer : NSObject {

    class func open_audiofile(filePath: String) {
        //get where the file is
        // let url = Bundle.main.url(forResource: filePath, withExtension: "mp3")
        let fileURL = URL(fileURLWithPath: filePath)
        // print(url!)
        //put it in an AVAudioFile
        let audioFile = try! AVAudioFile(forReading: fileURL)
        //Get the audio file format
        //let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: file.fileFormat.channelCount, interleaved: false)
        let audioFormat = audioFile.processingFormat
        let audioFrameCount = UInt32(audioFile.length)
        //how many channels?
        print("audioFile.fileFormat.channelCount: \(audioFile.fileFormat.channelCount)")
        print("audioFrameCount: \(audioFrameCount)")
        //Setup the buffer for audio data
        let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: UInt32(audioFile.length))
        //put audio data in the buffer
        try! audioFile.read(into: audioFileBuffer!)
        //readFile.arrayFloatValues = Array(UnsafeBufferPointer(start: audioFileBuffer!.floatChannelData?[0], count:Int(audioFileBuffer!.frameLength)))

        //Init engine and player
        let mainMixer = audioEngine.mainMixerNode
        audioEngine.attach(audioPlayer)
        audioEngine.connect(audioPlayer, to:mainMixer, format: audioFileBuffer!.format)
        audioPlayer.scheduleBuffer(audioFileBuffer!, completionHandler: nil)
        audioEngine.prepare()
        do {
            try audioEngine.start()
            print("engine started")
        } catch let error {
            print(error.localizedDescription)
        }
        audioPlayer.play()
    }
}