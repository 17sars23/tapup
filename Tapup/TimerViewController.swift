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
    
    @IBOutlet var labelClock: UILabel!

    var count: Int = 100
    var money: Float = 0.00
    let jikyu: Int = 1000
    
    var Worktimer: Timer = Timer()
    let now = Date()  //現在時刻
    
    
    //---------------------------------------
    // Setting function
    //---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Worktimer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(self.down),
                                     userInfo: nil, repeats: true)
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.displayClock), userInfo: nil, repeats: true)
        timer.fire()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //---------------------------------------
    // Original function
    //---------------------------------------
    
    //-----------------------------------//
    //              Timer
    //-----------------------------------//
    //---------timer settting-----------------------------------------------
    @objc func down(){
        let date2 = Date(timeInterval: 60*60*3, since: now) // 1週間と100秒前の日時
        let span = Int(now.timeIntervalSince(date2))
        
        let hours = span / 3600
        let minutes = (span - 3600 * hours) / 60
        let secs = (span - 3600 * hours - minutes * 60)
       // print(" \(hours)時間 \(minutes)分 \(secs)秒")
        
        
        count -= 1
        Worktimer_hourLabel.text = String(hours)
        Worktimer_minLabel.text = String(minutes)
        Worktimer_secLabel.text = String(secs)
        
        money_up(jikyu: jikyu)
 
        if count <= 0{
            Worktimer.invalidate()
        }
    }
    
    // 現在時刻を表示する処理--------------------------------------------
    @objc func displayClock() {
        // 現在時刻を「HH:MM:SS」形式で取得する
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        var displayTime = formatter.string(from: Date())    // Date()だけで現在時刻を表す
        
        // 0から始まる時刻の場合は「 H:MM:SS」形式にする
        if displayTime.hasPrefix("0") {
            // 最初に見つかった0だけ削除(スペース埋め)される
            if let range = displayTime.range(of: "0") {
                displayTime.replaceSubrange(range, with: " ")
            }
        }

        labelClock.text = displayTime
    }
    
    @IBAction func stop(){
        Worktimer.invalidate()
        //self.performSegue(withIdentifier: "Finish", sender: nil)
    }
    
    //-----------------------------------//
    //         Money  count
    //-----------------------------------//
    //---------timer settting-----------------------------------------------
    func money_up(jikyu: Int){
        let dif:Float = Float(jikyu)/3600
        
        money += dif
        money_Label.text = String(format: "%.2f", money)
    }
    
}
