//
//  ViewController.swift
//  Tapup
//
//  Created by kawagishi on 2018/02/13.
//  Copyright © 2018年 juna Kawagishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //---------------------------------------
    // Setting variable
    //---------------------------------------
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    private var myButton: UIButton!
    
    var count: Float = 15.00
    var timer: Timer = Timer()
    
    //---------------------------------------
    // Setting function
    //---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...8{
            createButton(button_num: i)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.down),
                                     userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //---------------------------------------
    // Original function
    //---------------------------------------
    
    //create button
    func createButton(button_num: Int){
        myButton = UIButton()
        
        let li_num: Int = button_num/3
        let row_num: Int = button_num%3
        let bWidth: CGFloat = 60
        let bHeight: CGFloat = 60
        
        let differ :CGFloat = (self.view.frame.width/5 - bWidth)/2
        
        let posX: CGFloat = self.view.frame.width/5 * CGFloat(row_num + 1) + differ
        let posY: CGFloat = self.view.frame.height/7 * CGFloat(li_num + 2)
        
        // ボタンの設置座標とサイズを設定する.
        myButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        myButton.backgroundColor = UIColor.blue //color
        myButton.layer.masksToBounds = true //丸み
        myButton.layer.cornerRadius = 20.0 //コーナの半径
        
        // タイトルを設定する(通常時).
        myButton.setTitle(String(button_num), for: .normal)
        myButton.setTitleColor(UIColor.white, for: .normal)
        
        myButton.tag = button_num //tag setting
        
        self.view.addSubview(myButton)
    }
    
    @objc func down(){
        count -= 0.01
        timerLabel.text = String(format: "%.2f", count)
    }


}

