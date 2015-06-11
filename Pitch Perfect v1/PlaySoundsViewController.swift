//
//  PlaySoundsViewController.swift
//  Pitch Perfect v1
//
//  Created by Todd Stephens on 6/9/15.
//  Copyright (c) 2015 Todd Stephens. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    // Global Variables
    // --------------------------------------------------------
    var audioPlayer: AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine = AVAudioEngine()
    var audioFile:AVAudioFile!
    
    
    
    // Click on Snail Button
    // --------------------------------------------------------
    @IBAction func btnSnail(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
   
    
    // Click on Chipmunk Button
    // --------------------------------------------------------
    @IBAction func btnChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    

    // Click on Darth Vader Button
    // --------------------------------------------------------
    @IBAction func btnDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    
    // Click on Rabbit Button
    // --------------------------------------------------------
    @IBAction func btnRabbit(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }

    // Click on Stop Button
    // --------------------------------------------------------
    @IBAction func btnStopPlayer(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    
    }
    
    
    // Function: Play Audio and Vary Pitch
    // --------------------------------------------------------
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
        
    }
    
    

    // View Did Load
    // --------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    // Memory Wartning
    // --------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
