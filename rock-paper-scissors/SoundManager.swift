//
//  SoundManager.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/11.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(named soundName: String){
    if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3"){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Sound error: \(error.localizedDescription)")
        }
    }
}
