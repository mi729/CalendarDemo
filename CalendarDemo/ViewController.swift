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
    let calendar = Calendar.current
    let today = Date()
    var eventArray: [EKEvent] = []

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        checkAuth()
        getEvents(today)
    }
    
    func getEvents(_ date: Date) {
//        var dataComponents = DateComponents()
        let predicate = eventStore.predicateForEvents(withStart: date, end: date, calendars: nil)
        eventArray = eventStore.events(matching: predicate)
        print(eventArray)
        table.reloadData()
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


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = table.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = eventArray[indexPath.row].title
        return cell
    }
    
}

