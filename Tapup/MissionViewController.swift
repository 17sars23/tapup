//
//  MissionViewController.swift
//  Tapup
//
//  Created by kawagishi on 2018/03/05.
//  Copyright © 2018年 juna Kawagishi. All rights reserved.
//

import UIKit

class MissionViewController: UIViewController {
    
    //---------------------------------------
    // Setting variable
    //---------------------------------------
    @IBOutlet var WorkLabel: UILabel!
    @IBOutlet var jikyuLabel: UILabel!
    @IBOutlet var sogakuLabel: UILabel!
    let SaveData: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jikyu = SaveData.integer(forKey: "jikyu")
        jikyuLabel.text = String(jikyu)

        let work_time = SaveData.integer(forKey: "work_time") + 1
        WorkLabel.text = String("\(work_time):00:00")

        sogakuLabel.text = String(jikyu*work_time)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
