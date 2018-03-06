//
//  InputViewController.swift
//  Tapup
//
//  Created by kawagishi on 2018/02/26.
//  Copyright © 2018年 juna Kawagishi. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //---------------------------------------
    // Setting variable
    //---------------------------------------
    @IBOutlet weak var moneytextField: UITextField!
    @IBOutlet weak var timetextField: UITextField!
    var label:UILabel!
    let SaveData: UserDefaults = UserDefaults.standard

    let dataList = ["1時間", "2時間", "3時間", "4時間", "5時間", "6時間", "7時間", "8時間", "9時間", "10時間"]
    
    //---------------------------------------
    // Setting function
    //---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // 時間
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        timetextField.inputView = pickerView
        
        //時給
        moneytextField.delegate = self
        moneytextField.keyboardType = UIKeyboardType.numberPad
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //---------------------------------------
    // Original function
    //---------------------------------------
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        moneytextField.resignFirstResponder() // キーボードを閉じる
        SaveData.set(moneytextField.text, forKey: "jikyu")
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.moneytextField.isFirstResponder) {
            self.moneytextField.resignFirstResponder()
            SaveData.set(moneytextField.text, forKey: "jikyu")
        }
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(dataList[row])
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timetextField.text = String(dataList[row])
        SaveData.set(row, forKey: "work_time")
    }

    @IBAction func start(){
        let now = Date()
        let timeinterval: Int = (SaveData.integer(forKey: "work_time")+1)*3600
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let end = Date(timeInterval: TimeInterval(timeinterval), since: now)
        let sDate = formatter.string(from: end)
        print("start:\(now)\n")
        print("end:\(sDate)\n")
        print(type(of: sDate))
        SaveData.set(sDate, forKey: "End_time")
        
        self.performSegue(withIdentifier: "toTimer", sender: nil)
    }
}
