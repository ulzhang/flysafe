//
//  ChildFeedViewController.swift
//  flysafe
//
//  Created by Kevin Zhang on 5/3/19.
//  Copyright © 2019 Kevin Zhang. All rights reserved.
//

import UIKit
//import Parse
// allows for local notifications
import UserNotifications

class ChildFeedViewController: UIViewController {
    
    var posts: [[String: Any]] = UserDefaults.standard.value(forKey: "posts") as! [[String : Any]]
    //    UserDefaults.standard.set(data, forKey: "data")
    
    let rev_key = UserDefaults.standard.string(forKey: "_rev")
    
    var count = 0

    @IBAction func logoutButton(_ sender: Any) {
        print("PUT")
        
        count += 1
        
        if (count > 12){
            count = 12
        }
        // old functional form
        //        let jsonURLString = "http://18.234.138.32:10089/Baggage_Claim_Notifications/interactions"
        //        guard let url = URL(string: jsonURLString) else
        //        {return}
        //        URLSession.shared.dataTask(with: url) {(data, response, err) in
        //            guard let data = data else {return}
        //
        //            do {
        //                let claim = try
        //                    JSONDecoder().decode(Claim.self, from: data)
        //                print(claim.Message)
        //                print(claim.Carousel)
        //                print(claim.Comment)
        //
        //            } catch let jsonErr {
        //                print("Error serializing json:", jsonErr)
        //            }
        //
        //            }.resume()
        
        let text: [[String:Any]] = [["status":"useless head",
                                     "body":"will never be seen"],
                                    
                                    
                                    
                                    ["status":"Special Request",
                                     "body":"Wheel Chair assistants has been fullfiled."],
                                    ["status":"Efren is ready for security check",
                                     "body":""],
                                    ["status":"Heading to their gate",
                                     "body":"Flight AA2404 to ORD will be departing from Gate 23 in Terminal C 12.40pm."],
                                    ["status":"Boarded",
                                     "body":"Efren has boarded Flight 2404 to ORD."],
                                    ["status":"Departed",
                                     "body":"The Flight AA2404 departed to ORD . Expected to arrive ORD 2.45PM."],
                                    ["status":"Arrived",
                                     "body":"The Flight AA2404 arrived at ORD."],
                                    ["status":"Heading to the Departure gate",
                                     "body":"Efren Flight AA51 to LHR will be departing from Gate 12 in Terminal D at 5.30PM."],
                                    ["status":"Boarded",
                                     "body":"Efren has boarded Flight AA51 to LHR."],
                                    ["status":"Departed",
                                     "body":"The Flight AA51 departed to LHR . Expected to arrive LHR 11.45PM."],
                                    ["status":"Arrived",
                                     "body":"The Flight AA51 arrived at LHR"],
                                    ["status":"Heading to Customs Clearance",
                                     "body":"Efren has headed to the customs check followed by baggage claim C31."]]
        
        var posts: [[String: Any]] = UserDefaults.standard.value(forKey: "posts") as! [[String : Any]]
        
        
        posts.insert(text[count], at: 0)
        
        
        UserDefaults.standard.set(posts, forKey: "posts")
        print("added")
        print(posts)
        print("added")
        
        let rev_key = UserDefaults.standard.string(forKey: "_rev")
        // prepare json data
        

        
        let json: [String: Any] = ["_rev": rev_key,
                                   "advnum":"1234568",
                                   "count": String(count),
                                   "status": text[count]["status"],
                                   "body": text[count]["status"]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://346e1f9f-32ae-4f00-847d-2238bdec4c5c-bluemix:dd469e316deaf5c6a7a83ffc4db2dc75b2a60b4c1090cf120adf4e481eedecf0@346e1f9f-32ae-4f00-847d-2238bdec4c5c-bluemix.cloudant.com/pnrinfo/02f75e3fd7feedff63bb27b38bd3c558")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                UserDefaults.standard.set(responseJSON["_rev"], forKey: "_rev")
            }
            else {
                print("this didn't work")
            }
        }
        
        task.resume()
        
        getRev()
        
        // run notification
        let center = UNUserNotificationCenter.current()
        // set notif content
        let content = UNMutableNotificationContent()
        content.title = posts[0]["status"] as! String
//        content.subtitle = "login subtitle"
        content.body = posts[0]["body"] as! String
        content.sound = UNNotificationSound.default
        //        content.badge = 1
        content.threadIdentifier = "local-notification temp"
        
        
        let date = Date(timeIntervalSinceNow: 1)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        // set trigger time
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // set request
        
        let requestNotif = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(requestNotif) { (error) in
            if error != nil {
                print(error)
            }
        }
        
        //        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        // send to notif center
        //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        print("notifications ran")
    }
    
    func getRev(){
        print("GET")
        
        
        // prepare json data
        let json: [String: Any] = ["_rev": rev_key,
                                   "advnum":"1234568",
                                   "kevin":"zhang"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://346e1f9f-32ae-4f00-847d-2238bdec4c5c-bluemix:dd469e316deaf5c6a7a83ffc4db2dc75b2a60b4c1090cf120adf4e481eedecf0@346e1f9f-32ae-4f00-847d-2238bdec4c5c-bluemix.cloudant.com/pnrinfo/02f75e3fd7feedff63bb27b38bd3c558")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                
                UserDefaults.standard.set(responseJSON["_rev"], forKey: "_rev")
                print("new rev")
                print(responseJSON["_rev"])
            }
            else {
                print("this didn't work")
            }
            
            
        }
        
        task.resume()
    }
    
    @IBAction func addOneToTxtFile(_ sender: Any) {
        count += 1
        /*** Save to project txt file ***/
        var fileURLProject = Bundle.main.url(forResource: "ProjectTextFile", withExtension: "txt")
        
        //        print("FilePath: \(fileURLProject.path)")
        
        let writeString = String(count)
        do {
            // Write to the file
            try writeString.write(to: fileURLProject!, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURLProject), Error: " + error.localizedDescription)
        }
        
        print("made change to child feed")

    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getRev()
        // Do any additional setup after loading the view.
        let center = UNUserNotificationCenter.current()
        
        


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
