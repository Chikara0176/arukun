//
//  ViewController.swift
//  Buy家具
//
//  Created by 坂本一 on 2015/10/02.
//  Copyright (c) 2015年 Hajime Sakamoto. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet var Scroll: UIScrollView!
    var phoneSize :CGSize = UIScreen.mainScreen().bounds.size //画面サイズ
    private var myWindow :UIWindow!
    var BuyButton :UIButton!
    var backButton :UIButton! //戻るボタン
    var cancelButton :UIButton! //キャンセルボタン
    var SetButtons :Array<UIButton> = []
    private var myTextView :UITextView! //家具の名前
    private var Text :UITextView! //テキスト
    private var PointView :UITextView! //所持ポイント表示
    private var price :UITextView! //値段
    var imageView :UIImageView! //これは商品
    var boughtImage = UIImage(named: "bought") //購入済み
    var PlayerPoint :Int = 1000   //お金
    var BuyFurniture :Dictionary<String,String>! //何を買おうとしてるのか
    var selected: Int!  //選んだ番号
    var bought :Array<UIImageView> = [] //買ったのどうなの
    
    //家具
    var data = [
        ["name" :"木のイス", "point" :"100", "have" :"false", "pic" :"kagu1"],
        ["name" :"しゃれたイス", "point" :"150", "have" :"false", "pic" :"kagu2"],
        ["name" :"こさねぇ", "point" :"100" ,"have" :"true", "pic" :"kagu3"],
        ["name" :"観葉植物", "point" :"80" ,"have" :"false", "pic" :"kagu4"],
        ["name" :"素朴な背景", "point" : "700", "have" :"false", "pic" :"back1"]
    ]    //場所
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var heightScroll = ceil(Double(data.count) / 2.0)
        Scroll.contentSize = CGSize(width:0 , height: 180*heightScroll)
        Scroll.indicatorStyle = UIScrollViewIndicatorStyle.Black
        
        //購入ボタン作成
        BuyButton = UIButton(frame: CGRectMake(0, 0, 100, 50))
        BuyButton.backgroundColor = UIColor.redColor()
        BuyButton.addTarget(self, action: "BuyFurniture:", forControlEvents: .TouchUpInside)
        BuyButton.setTitle("購入", forState: .Normal)
        BuyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        BuyButton.setTitle("購入", forState: .Highlighted)
        BuyButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        BuyButton.layer.position = CGPoint(x: 150, y: 200)

        //キャンセルボタン作成
        cancelButton = UIButton(frame: CGRectMake(0, 0, 100, 50))
        cancelButton.backgroundColor = UIColor.blueColor()
        cancelButton.addTarget(self, action: "Goback:", forControlEvents: .TouchUpInside)
        cancelButton.setTitle("キャンセル", forState: .Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelButton.setTitle("キャンセル", forState: .Highlighted)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        cancelButton.layer.position = CGPoint(x: 150, y: 250)
        
        //戻るボタン作成
        backButton = UIButton(frame: CGRectMake(0, 0, 100, 50))
        backButton.backgroundColor = UIColor.blueColor()
        backButton.addTarget(self, action: "Goback:", forControlEvents: .TouchUpInside)
        backButton.setTitle("戻る", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.setTitle("戻る", forState: .Highlighted)
        backButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        backButton.layer.position = CGPoint(x: 150, y: 250)

        
        //これはテキスト
        Text = UITextView(frame: CGRectMake(0, 0, 300, 100))
        Text.userInteractionEnabled = true
        Text.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        Text.text = ""
        Text.font = UIFont.systemFontOfSize(CGFloat(20))
        Text.textColor = UIColor.blackColor()
        Text.textAlignment = NSTextAlignment.Left
        Text.editable = false
        Text.center = CGPointMake(self.view.frame.width/2,100)
        
        PointView = UITextView(frame: CGRectMake(0, 0, 300, 100))
        PointView.userInteractionEnabled = true
        PointView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        PointView.text = "所持ポイント：\(toString(PlayerPoint))P"
        PointView.font = UIFont.systemFontOfSize(CGFloat(20))
        PointView.textColor = UIColor.blackColor()
        PointView.textAlignment = NSTextAlignment.Left
        PointView.editable = false
        PointView.center = CGPointMake(self.view.frame.width*0.5,self.view.frame.height*0.85)
        self.view.addSubview(PointView)

        


        for i in 0...4 { //メイン画面の用意
            var output = self.data[i]
            //コイツが1単位
            var View = UIView()
            View.userInteractionEnabled = true
            var HGH :CGFloat = 180  //高さの間隔
            var WhereY = floor(CGFloat(i/2)) //何行目？
            var which :CGFloat = CGFloat(i%2)
            View.frame = CGRectMake(150*which, HGH*WhereY, 150, 150)
            
            //画像の用意
            var Image = UIImage(named: output["pic"]!)
            imageView = UIImageView(image: Image)
            imageView.frame = CGRectMake(0, 0, 120, 120)
            imageView.center = CGPointMake(75,90)
            imageView.tag = i
            imageView.userInteractionEnabled = true
            
            //画像にアクション適用、表示
            let action = UITapGestureRecognizer(target:self, action: "makeWindow:")
            imageView.addGestureRecognizer(action)
            View.addSubview(imageView)
            
            //商品名
            myTextView = UITextView(frame: CGRectMake(0, 0, 130, 30))
            myTextView.userInteractionEnabled = false
            myTextView.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.8, alpha: 1.0)
            myTextView.text = output["name"]!
            myTextView.font = UIFont.systemFontOfSize(CGFloat(15))
            myTextView.textColor = UIColor.whiteColor()
            myTextView.textAlignment = NSTextAlignment.Center
            myTextView.editable = false
            myTextView.center = CGPointMake(75,15)
            View.addSubview(myTextView)
            
            //値段を入れる
            price = UITextView(frame: CGRectMake(0, 0, 50, 30))
            price.userInteractionEnabled = false
            price.editable = false
            price.text = output["point"]!
            price.backgroundColor = UIColor.orangeColor()
            price.font = UIFont.systemFontOfSize(CGFloat(15))
            price.textColor = UIColor.whiteColor()
            price.textAlignment = NSTextAlignment.Left
            price.center = CGPointMake(125,135)
            View.addSubview(price)
            
            bought.append(UIImageView(image: boughtImage))
            bought[i].frame = CGRectMake(0, 0, 50, 50)
            bought[i].center = CGPointMake(75, 75)
            View.addSubview(bought[i])
            bought[i].tag = i
            if(output["have"]! == "false"){
                bought[i].hidden = true
            }
            
            Scroll.addSubview(View)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func Goback(sender: UIButton){ //戻る
        myWindow.hidden = true
    }
    
    internal func BuyFurniture(sender: UIButton){ //買う
        PlayerPoint = PlayerPoint - BuyFurniture["point"]!.toInt()!
        BuyButton.removeFromSuperview()
        myWindow.addSubview(backButton)
        Text.text = "購入しました！"
        BuyFurniture.updateValue("true", forKey: "have")
        data[selected] = BuyFurniture
        bought[selected].hidden = false
        PointView.text = "所持ポイント：\(toString(PlayerPoint))P"
    }

    
    func makeWindow(recognizer: UIGestureRecognizer){ //ウィンドウ作成
        if let imageView = recognizer.view as? UIImageView {
            selected = imageView.tag
            BuyFurniture = data[selected]
            var Flg = ( BuyFurniture["have"]! )
            if(Flg == "false"){
                //まずはウィンドウ作ろう
                myWindow = UIWindow(frame: CGRectMake(0, 0, 300, 300))
                myWindow.backgroundColor = UIColor.whiteColor()
                myWindow.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
                myWindow.alpha = 1.0
                // myWindowをkeyWindowにする.
                myWindow.makeKeyWindow()
                self.view.addSubview(myWindow)
                self.myWindow.makeKeyAndVisible()

                var FurniturePoint = BuyFurniture["point"]!.toInt()!
                if(PlayerPoint >= FurniturePoint){ //足りる！
                    var name = BuyFurniture["name"]!
                    Text.text = "\(name)を購入しますか？\n必要ポイント：\(FurniturePoint)P\n所持ポイント：\(PlayerPoint)P"
                    myWindow.addSubview(Text)
                    myWindow.addSubview(BuyButton)
                    myWindow.addSubview(cancelButton)
                }else { //足りない！
                    Text.text = "ポイントが足りません！\n必要ポイント：\(FurniturePoint)P\n所持ポイント：\(PlayerPoint)P"
                    myWindow.addSubview(Text)
                    myWindow.addSubview(backButton)
                }
            }
        }
    }
    
}