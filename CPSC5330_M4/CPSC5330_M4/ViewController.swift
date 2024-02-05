//
//  ViewController.swift
//  UIKit_Elements
//
//  Created by Lauren Thompson on 6/6/23.
//


import UIKit
//Music
//import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    var clockTimer: Timer?
    var countdownTimer: Timer?
    var remainingTime: TimeInterval = 0
    //var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial background image based on current time
        setBackgroundBasedOnTime()
        
        // Start live clock
        startClock()
        
        // Configure time picker
        timePicker.datePickerMode = .countDownTimer
        
        // Configure label2 for countdown timer
        label2.text = "00:00:00"
        
       
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Update background image on device rotation
        setBackgroundBasedOnTime()
    }
    
    //AM string for morning_image
    //otherwise evening_image
    
    func setBackgroundBasedOnTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        let currentTime = Date()
        let amPMString = dateFormatter.string(from: currentTime)
        
        if amPMString == "AM" {
            backgroundImageView.image = UIImage(named: "morning_image")
        } else {
            backgroundImageView.image = UIImage(named: "evening_image")
        }
    }
    
    func startClock() {
        clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        let currentTime = Date()
        let timeString = dateFormatter.string(from: currentTime)
        label1.text = timeString
    }
    
   
 
        var timer: Timer?
        var targetTime: Date?
        
      
        @IBAction func timerButtonTapped(_ sender: UIButton) {
            if timer == nil {
                startTimer()
            } else {
                stopTimer()
                resetTimer()
            }
        }
        
        func startTimer() {
            targetTime = timePicker.countDownDuration > 0 ? Date().addingTimeInterval(timePicker.countDownDuration) : nil
            
            if let targetTime = targetTime {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                    let timeRemaining = max(targetTime.timeIntervalSinceNow, 0)
                    let hours = Int(timeRemaining) / 3600
                    let minutes = (Int(timeRemaining) % 3600) / 60
                    let seconds = Int(timeRemaining) % 60
                    
                    self?.label2.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                    
                    if timeRemaining <= 0 {
                        self?.stopTimer()
                        self?.timerButton.setTitle("Start Timer", for: .normal)
                    }
                }
                
                timerButton.setTitle("Stop Timer", for: .normal)
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
        
        func resetTimer() {
            timePicker.countDownDuration = 0
            label2.text = "00:00:00"
            timerButton.setTitle("Start Timer", for: .normal)
        }
    }

