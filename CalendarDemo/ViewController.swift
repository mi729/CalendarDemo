//
//  ViewController.swift
//  CalendarDemo
//
//  Created by nyagoro on 2020/07/23.
//  Copyright © 2020 Nyago. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    var eventStore = EKEventStore() 

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
    }
    
    func checkAuth() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        if status == .authorized {
            print("アクセスできます！！")
        }else if status == .notDetermined {
            // アクセス権限のアラートを送る。
            eventStore.requestAccess(to: EKEntityType.event) { (granted, error) in
                if granted {
                    print("アクセス可能になりました。")
                }else {
                    print("アクセスが拒否されました。")
                }
            }
        }
    }


}

