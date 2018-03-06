//
//  RankingViewController.swift
//  Tapup
//
//  Created by kawagishi on 2018/02/18.
//  Copyright © 2018年 juna Kawagishi. All rights reserved.
//

import UIKit
import Social

class RankingViewController: UIViewController {
    
    //---------------------------------------
    // Setting variable
    //---------------------------------------
    @IBOutlet var scoreLabel1: UILabel!
    @IBOutlet var scoreLabel2: UILabel!
    @IBOutlet var scoreLabel3: UILabel!
    @IBOutlet var scoreLabel4: UILabel!
    @IBOutlet var scoreLabel5: UILabel!
    
    let SaveData: UserDefaults = UserDefaults.standard
    
    @IBOutlet var lastscoreLabel: UILabel!
    var result: Int!
    
    
    //---------------------------------------
    // Setting function
    //---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        result = SaveData.integer(forKey: "last_score")
        lastscoreLabel.text = String(result) + "pt"
        
        SaveData.register(defaults: ["rank": [0,0,0,0,0]])
        
        let RankArray = ReRanking()
        //もしここで，遷移元を取得して，遷移元によって動作を変えるならどう書く？どうやって遷移元を取得する？
        
        //Ranking show
        for i in 0...4{
            let label = value(forKey: "scoreLabel\(i+1)") as! UILabel
            label.text = String(RankArray[i]) + "pt"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //---------------------------------------
    // Original function
    //---------------------------------------
    //---------Re Ranking ---------------------------------------
    func ReRanking() -> Array<Int>{
        var rArray = SaveData.array(forKey: "rank") as! [Int]
        
        rArray.append(SaveData.integer(forKey: "last_score"))
        rArray.sort(by: {$0 > $1}) //sort
        rArray.removeLast()
        print(rArray)

        SaveData.set(rArray, forKey: "rank")
        SaveData.set(0, forKey: "last_score")
        return rArray
    }
    
    @IBAction func rank_reset(){
        let reset_array = [0,0,0,0,0]
        SaveData.set(reset_array, forKey: "rank")
        
        for i in 0...4{
            let label = value(forKey: "scoreLabel\(i+1)") as! UILabel
            label.text = String(reset_array[i]) + "pt"
        }
    }
    
    @IBAction func twitter(){
        
       // let composer = TWTRComposer()
        //composer.setText(text)
        //composer.show(from: viewController, completion: { result in ... })
    }
    
   
}
