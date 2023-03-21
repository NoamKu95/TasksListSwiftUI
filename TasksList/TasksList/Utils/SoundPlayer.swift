//
//  SoundPlayer.swift
//  TasksList
//
//  Created by Noam Kurtzer on 21/03/2023.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Couldnt find and paly sound file")
        }
    }
}
