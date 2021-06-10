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
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7 ]
    // From minutes to seconds 5min = 300 seconds
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        //print(sender.currentTitle as Any)
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        progressBar.progress = 0.0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,  selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
        
        
    }
    @objc func updateTimer(){
        if secondsPassed <= totalTime {
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            progressBar.progress = percentageProgress
            secondsPassed+=1
        }
        else{
            timer.invalidate()
            titleLabel.text = "Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                        player = try! AVAudioPlayer(contentsOf: url!)
                        player.play()
        }
    }
    
}
