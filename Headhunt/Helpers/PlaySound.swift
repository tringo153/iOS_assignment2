//
//  PlaySound.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 23/08/2022.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?
var soundPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file")
        }
    }
}

func playSoundEffect(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            soundPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file")
        }
    }
}

func pauseMusic() {
    audioPlayer?.pause()
}

func stopMusic() {
    audioPlayer?.stop()
}

func resumeMusic() {
    audioPlayer?.play()
}

