//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 10, "Medium": 15, "Hard": 20]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0
        
        if let title = sender.currentTitle {
            self.totalTime = eggTimes[title]!
            self.secondPassed = 0
            titleLabel.text = title
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }

    @objc func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
