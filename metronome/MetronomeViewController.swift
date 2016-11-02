//
//  MetronomeViewController.swift
//  metronome
//
//  Created by Kyle Borodkin on 10/28/16.
//  Copyright © 2016 Kyle Borodkin. All rights reserved.
//

import UIKit
import AVFoundation

class MetronomeViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var bpmLabel: UILabel!
    
    var player: AVAudioPlayer?
    var timer: Timer!
    var tempo: TimeInterval = 130.0
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        var currentValue = Int(sender.value)
        bpmLabel.text = "\(currentValue)"
        tempo = Double(currentValue)
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if sender.currentTitle == "play" {
            sender.setTitle("stop", for: UIControlState.normal)
            let metronomeTimeInterval:TimeInterval = 60.0 / tempo
            timer = Timer.scheduledTimer(timeInterval: metronomeTimeInterval, target: self, selector: #selector(MetronomeViewController.playSound), userInfo: nil, repeats: true)
            timer.fire()
            playSound();
        }
        else {
            sender.setTitle("play", for: UIControlState.normal)
            timer.invalidate()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "Metronome", withExtension: "wav")
    
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch let error as Error {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

