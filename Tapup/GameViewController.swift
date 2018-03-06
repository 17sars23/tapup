//
//  ViewController.swift
//  Tapup
//
//  Created by kawagishi on 2018/02/13.
//  Copyright © 2018年 juna Kawagishi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //---------------------------------------
    // Setting variable
    //---------------------------------------
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var countdownLabel: UILabel!
    
    private var myButton: UIButton!
    
    var count: Float =  15.00
    var push_count: Int = 1
    var score: Int = 0
    var timer: Timer = Timer()
    
    var checkArray:[Int] = [0,0,0,0,0,0,0,0,0]
    
    let SaveData: UserDefaults = UserDefaults.standard
    
    //---------------------------------------
    // Setting function
    //---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = String(score) + "pt"

        for i in 1...9{
            createButton(button_num: i)
        }
        
        countdownLabel.frame = CGRect(x:100, y:200, width:120, height:120)
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 100)
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.down),
                                     userInfo: nil, repeats: true)
        
        animateImage(target: imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ////////////////////////////////////////////////
    // Original function
    ////////////////////////////////////////////////
    
    //-----------------------------------//
    //             Bottun
    //-----------------------------------//
    //-----------create button -----------------------------------
    func createButton(button_num: Int){
        myButton = UIButton()
        
        var r: Int = 0
        
        repeat{
            r = Int(arc4random_uniform(9))
        }while(checkArray[r] == 1)
        
        checkArray[r] = 1
        
        let li_num: Int = r/3
        let row_num: Int = r%3
        let bWidth: CGFloat = 80
        let bHeight: CGFloat = 80
        
        let differ :CGFloat = bWidth/2

        let posX: CGFloat = self.view.frame.height/9 * CGFloat(row_num*3 + 7) - differ
        let posY: CGFloat = self.view.frame.width/8 * CGFloat(li_num) + differ/2
        
        // ボタンの設置座標とサイズを設定する.
        myButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        
        myButton.setBackgroundImage(UIImage(named:"sports_archery_mato2"), for: .normal) // 画像を設定
        
        // タイトルを設定する.
        myButton.setTitle(String(button_num), for: .normal)
        myButton.setTitleColor(UIColor.black, for: .normal)
        
        myButton.tag = button_num //tag setting
        self.view.addSubview(myButton) //表示
        
        //Tap action
        myButton.addTarget(self,
                           action: #selector(self.buttonTapped(sender:)),
                           for: .touchDown)
        
        //animateImage(target: myButton)
    }
    
    //---------Tap action-----------------------------------------------
    @objc func buttonTapped(sender: UIButton){
        
        if judge(num: Int(sender.tag)) == true{
            sender.setTitle(" ", for: .normal)
            
            let xPosition = sender.frame.origin.x + sender.frame.size.width/2
            let yPosition = sender.frame.origin.y + sender.frame.size.height/2
            
            UIView.animate(withDuration: 0.3, animations: {
                sender.frame = CGRect(x:xPosition, y:yPosition, width:0, height:0)
            })
        }
    }
    
    
    //---------judgement-----------------------------------------------
    func judge(num: Int) -> Bool{
        if push_count == num{
            push_count += 1
            score_up()
            if push_count == 10{
                reset()
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.up),
                                             userInfo: nil, repeats: false)
            }
            return true
        }else{
            return false
        }
    }
    
    //-----------------------------------//
    //              Timer
    //-----------------------------------//
    //---------timer settting-----------------------------------------------
    @objc func down(){
        count -= 0.01
        timerLabel.text = String(format: "%.2f", count)
        
        if count <= 3.00 && count > 2.00{
            countdownLabel.text = "3"
            countdownLabel.textColor = UIColor.blue
            self.view.addSubview(countdownLabel)
        }else if count <= 2.00 && count > 1.00{
            countdownLabel.text = "2"
            countdownLabel.textColor = UIColor.yellow
            self.view.addSubview(countdownLabel)
        }else if count <= 1.00 && count > 0.00{
            countdownLabel.text = "1"
            countdownLabel.textColor = UIColor.red
            self.view.addSubview(countdownLabel)
        }else{
            countdownLabel.text = " "
            self.view.addSubview(countdownLabel)
            
        }
        
        //画面遷移
        if count <= 0.00{
            timer.invalidate()
            count = 15.00
            
            //score save
            SaveData.set(score, forKey: "last_score")
            self.performSegue(withIdentifier: "toResult", sender: nil)
        }
    }
    
    //---------vonus time up-----------------------------------------------
    @objc func up(){
        count += 3.00
        timerLabel.text = String(format: "%.2f", count)
    }
    
    //-----------------------------------//
    //              Other
    //-----------------------------------//
    //---------reset-----------------------------------------------
    func reset(){
        checkArray = [0,0,0,0,0,0,0,0,0]
        push_count = 1
        for i in 1...9{
            createButton(button_num: i)
        }
    }
    
    
    //---------score-----------------------------------------------
    func score_up(){
        score += 10
        scoreLabel.text = String(score) + "pt"
    }

    
    //---------animation-----------------------------------------------
    func animateImage(target: UIView){
        target.frame.origin.x = 220
        
        UIView.animate(withDuration: 3.0, delay: 0.0,
                       options: [.curveEaseIn, .autoreverse],
                          animations: {
                            // 画面左まで移動
                            target.frame.origin.x = self.view.frame.width // - target.frame.origin.width
                            
        },
                          completion: { _ in
                            // 画面左まで行ったら、画面右に戻す
                            target.frame.origin.x -= self.view.frame.height
                            // 再度アニメーションを起動
                            self.animateImage(target: target) }
        )
    }
    
}

