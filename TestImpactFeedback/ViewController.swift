//
//  ViewController.swift
//  TestImpactFeedback
//
//  Created by Ghost on 2020/5/27.
//  Copyright © 2020 Ghost. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func impactBtnClick(_ sender: UIButton) {
        let style = NXImpactFeedback.ImpactFeedbackStyle(rawValue: sender.tag)!
        NXImpactFeedback.impactFeedback(style: style)
    }
}

class NXImpactFeedback: NSObject {
    public enum ImpactFeedbackStyle : Int {
        case success = 0
        
        case warning = 1
        
        case error = 2
        
        case light = 10

        case medium = 11
        
        case heavy = 12
        
        @available(iOS 13.0, *)
        case soft = 13
        
        @available(iOS 13.0, *)
        case rigid = 14
        
        case sys1519 = 1519
        
        case sys1520 = 1520
        
        case sys1521 = 1521
    }
    
    class func impactFeedback(style : ImpactFeedbackStyle) {
        if style.rawValue < 10 {
            let generator = UINotificationFeedbackGenerator.init()
            let type = UINotificationFeedbackGenerator.FeedbackType(rawValue: style.rawValue)!
            generator.notificationOccurred(type);
        }else if style.rawValue >= 10 && style.rawValue < 20 {
            let type = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: (style.rawValue - 10))!
            let generator = UIImpactFeedbackGenerator.init(style: type)
            generator.prepare()
            generator.impactOccurred()
        }else {
            AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(style.rawValue)) {
                print("\(style.rawValue) play finished")
            }
        }
    }
}
