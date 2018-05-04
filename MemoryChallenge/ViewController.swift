//
//  ViewController.swift
//  MemoryChallenge
//
//  Created by 許銘仁 on 2018/4/18.
//  Copyright © 2018年 Xumingjen. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    var imageName = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg","11.jpg","12.jpg"]
    
    @IBOutlet weak var Card1: UIButton!
    @IBOutlet weak var Card2: UIButton!
    @IBOutlet weak var Card3: UIButton!
    @IBOutlet weak var Card4: UIButton!
    @IBOutlet weak var Card5: UIButton!
    @IBOutlet weak var Card6: UIButton!
    @IBOutlet weak var Card7: UIButton!
    @IBOutlet weak var Card8: UIButton!
    @IBOutlet weak var Card9: UIButton!
    @IBOutlet weak var Card10: UIButton!
    @IBOutlet weak var Card11: UIButton!
    @IBOutlet weak var Card12: UIButton!
    @IBOutlet weak var Card13: UIButton!
    @IBOutlet weak var Card14: UIButton!
    @IBOutlet weak var Card15: UIButton!
    @IBOutlet weak var Card16: UIButton!
    @IBOutlet weak var Card17: UIButton!
    @IBOutlet weak var Card18: UIButton!
    @IBOutlet weak var Card19: UIButton!
    @IBOutlet weak var Card20: UIButton!
    @IBOutlet weak var Card21: UIButton!
    @IBOutlet weak var Card22: UIButton!
    @IBOutlet weak var Card23: UIButton!
    @IBOutlet weak var Card24: UIButton!
    @IBOutlet weak var Score: UITextField!
    
    var AllCard : [UIButton] = [UIButton]()
    
    var guestTime = 2
    var guestImage : [UIImage] = [UIImage]()
    var guestImageNum : [Int] = [Int]()
    var currentScore = 0 //計算分數
    var startGame = true //用來判斷遊戲是否開始
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AllCard.append(Card1)
        AllCard.append(Card2)
        AllCard.append(Card3)
        AllCard.append(Card4)
        AllCard.append(Card5)
        AllCard.append(Card6)
        AllCard.append(Card7)
        AllCard.append(Card8)
        AllCard.append(Card9)
        AllCard.append(Card10)
        AllCard.append(Card11)
        AllCard.append(Card12)
        AllCard.append(Card13)
        AllCard.append(Card14)
        AllCard.append(Card15)
        AllCard.append(Card16)
        AllCard.append(Card17)
        AllCard.append(Card18)
        AllCard.append(Card19)
        AllCard.append(Card20)
        AllCard.append(Card21)
        AllCard.append(Card22)
        AllCard.append(Card23)
        AllCard.append(Card24)
        for i in 0...AllCard.count-1{
            AllCard[i].setTitle(nil, for: .normal)
        }
        checkerBoard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectCard(_ sender: UIButton) { //抓取點擊的button是第幾個，並判斷動作
        for i in 0...AllCard.count-1{
            if(sender == AllCard[i]){
                if(startGame == false){ //確認是否開始遊戲了
                    if(guestTime != 0){
                        guestTime -= 1;
                        guestImage.append(AllCard[i].currentBackgroundImage!)
                        guestImageNum.append(i)
                        AllCard[i].setImage(nil, for: .normal)
                        //避免點擊到同樣button，鎖起來
                        AllCard[i].isEnabled = false
                        print(i)
                    }else if(guestTime == 0){
                        guestTime = 2
                        if(guestImage[0].isEqual(guestImage[1])){
                            AllCard[guestImageNum[0]].isHidden = true
                            AllCard[guestImageNum[1]].isHidden = true
                            guestImage.removeAll()
                            guestImageNum.removeAll()
                            currentScore += 10
                            Score.text = String(currentScore)
                        }else{
                            AllCard[guestImageNum[0]].setImage(UIImage(named: "問號.jpg")?.withRenderingMode(.alwaysOriginal), for: .normal)
                            AllCard[guestImageNum[1]].setImage(UIImage(named: "問號.jpg")?.withRenderingMode(.alwaysOriginal), for: .normal)
                            AllCard[guestImageNum[0]].isEnabled = true
                            AllCard[guestImageNum[1]].isEnabled = true
                            guestImage.removeAll()
                            guestImageNum.removeAll()
                            currentScore -= 10
                            Score.text = String(currentScore)
                        }
                        guestTime -= 1;
                        guestImage.append(AllCard[i].currentBackgroundImage!)
                        guestImageNum.append(i)
                        AllCard[i].setImage(nil, for: .normal)
                        AllCard[i].isEnabled = false
                    }
                }
            }
        }
    }
    
    
    
    
    func checkerBoard(){ //產生出遊戲題目
        //亂數
        let shuffledDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: imageName.count - 1)
        var count = 0;
        for i in 0...5{
            let index1  = shuffledDistribution.nextInt()
            let index2  = shuffledDistribution.nextInt()
            let index3  = shuffledDistribution.nextInt()
            let index4  = shuffledDistribution.nextInt()
            AllCard[count].setBackgroundImage(UIImage(named: imageName[index1]), for: .normal)
            count += 1
            
            AllCard[count].setBackgroundImage(UIImage(named: imageName[index2]), for: .normal)
            count += 1
            
            AllCard[count].setBackgroundImage(UIImage(named: imageName[index3]), for: .normal)
            count += 1

            AllCard[count].setBackgroundImage(UIImage(named: imageName[index4]), for: .normal)
            count += 1
        }
    }
    
    @IBAction func reStartGame(_ sender: Any) {
        checkerBoard()
        for i in 0...AllCard.count-1{
            AllCard[i].isHidden = false
        }
        for i in 0...AllCard.count-1{
            AllCard[i].setImage(nil, for: .normal)
        }
        for i in 0...AllCard.count-1{
            AllCard[i].isEnabled = true
        }
        guestImage.removeAll()
        guestImageNum.removeAll()
        guestTime = 2
        Score.text = ""
        currentScore = 0
        startGame = true
    }
    
    @IBAction func startGame(_ sender: Any) {
        if(startGame){
            for i in 0...AllCard.count-1{
                AllCard[i].setImage(UIImage(named: "問號.jpg")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            Score.text = ""
            currentScore = 0
            startGame = false
        }else{
            print("game start can not stop")
        }
    }
}

