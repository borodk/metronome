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
    
    var isOn = false
    var player: AVAudioPlayer?
    var timer: Timer!
    var tempo: TimeInterval = 130.0
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        var currentValue = Int(sender.value)
        bpmLabel.text = "\(currentValue)"
        tempo = Double(currentValue)
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if isOn == true {
            isOn = false
            timer.invalidate()
            sender.setImage(UIImage(named:"ic_play_arrow_36pt_2x.png"), for: UIControlState.normal)
            print(isOn)
        } else {
            isOn = true
            sender.setImage(UIImage(named:"ic_stop_36pt_2x.png"), for: UIControlState.normal)
            let metronomeTimeInterval:TimeInterval = 60.0 / tempo
            timer = Timer.scheduledTimer(timeInterval: metronomeTimeInterval, target: self, selector: #selector(MetronomeViewController.playSound), userInfo: nil, repeats: true)
            timer.fire()
            playSound()
            print(isOn)
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

