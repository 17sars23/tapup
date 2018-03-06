//
//  TimerViewController.swift
//  Tapup
//
//  Created by kawagishi on 2018/02/26.
//  Copyright © 2018年 juna Kawagishi. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    //---------------------------------------
    // Setting variable
    //---------------------------------------
    @IBOutlet var Worktimer_hourLabel: UILabel!
    @IBOutlet var Worktimer_minLabel: UILabel!
    @IBOutlet var Worktimer_secLabel: UILabel!
    @IBOutlet var money_Label: UILabel!
    
    let SaveData: UserDefaults = UserDefaults.standard
    var money: Float = 0.00
    var jikyu: Int!
    var Worktimer: Timer = Timer()
    var end_time: Date!
    var max: Int!
    
    //---------------------------------------
    // Setting function
    //---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let check = SaveData.string(forKey: "End_time")!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        end_time = formatter.date(from: check)
        
        jikyu = SaveData.integer(forKey: "jikyu")
        let w = SaveData.integer(forKey: "work_time") + 1
        max = jikyu*w
        
        Worktimer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(self.down),
                                     userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ///////////////////////////////////////////
    // Original function
    //////////////////////////////////////////
    
    //---------timer settting-----------------------------------------------
    @objc func down(){
        let now = Date()
        let span = Int(end_time.timeIntervalSince(now))
        
        let hours = span / 3600
        let minutes = (span - 3600 * hours) / 60
        let secs = (span - 3600 * hours - minutes * 60)
        
        Worktimer_hourLabel.text = String(format: "%02d", hours)
        Worktimer_minLabel.text = String(format: "%02d", minutes)
        Worktimer_secLabel.text = String(format: "%02d", secs)
        
        money_up(span: span)
        
        if span <= 0{
            Worktimer.invalidate()
            self.performSegue(withIdentifier: "toMission", sender: nil)
        }
    }
    

    //---------Money Timer-----------------------------------------------
    func money_up(span: Int){
        let dif:Float = Float(jikyu)/3600
        money = Float(max) - dif*Float(span)
        money_Label.text = String(format: "%.1f", money)
    }

}
