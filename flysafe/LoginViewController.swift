//
//  LoginViewController.swift
//  flysafe
//
//  Created by Kevin Zhang on 5/3/19.
//  Copyright © 2019 Kevin Zhang. All rights reserved.
//

import UIKit

// allows for local notifications
import UserNotifications

struct Claim: Decodable {
    let Message: String
    let Carousel: String
    let Comment: String
}

class LoginViewController: UIViewController {
    
   let rev_key = UserDefaults.standard.string(forKey: "_rev")
    
    var count = 0

    @IBAction func APICallTester(_ sender: Any) {
//        getRev()
        print("PUT")
        
        count += 1
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
        
        let rev_key = UserDefaults.standard.string(forKey: "_rev")
        // prepare json data
        let json: [String: Any] = ["_rev": rev_key,
                                   "advnum":"1234568",
                                   "kevin":"zhang",
        "words":"more words"]
        
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
    }
    
    @IBAction func APICallerGetTest(_ sender: Any) {
        getRev()
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
                print("old rev")
                print(self.rev_key)
                
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
    @IBAction func loginButton(_ sender: Any) {
        print("logged in")
//        let center = UNUserNotificationCenter.current()
//        // set notif content
//        let content = UNMutableNotificationContent()
//        content.title = "login title"
//        content.subtitle = "login subtitle"
//        content.body = "login body"
//        content.sound = UNNotificationSound.default
////        content.badge = 1
//        content.threadIdentifier = "local-notification temp"
//        
//        
//        let date = Date(timeIntervalSinceNow: 10)
//        
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        
//        // set trigger time
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//        
////        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        
//        // set request
//        
//        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
//        
//        center.add(request) { (error) in
//            if error != nil {
//                print(error)
//            }
//        }
//        
////        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
//        
//        // send to notif center
////        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//        
//        print("notifications ran")
//        
//        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRev()
        
        let data: [String: Any] = ["status": "Check In to Flight",
                                   "body":"Please remember to check in online and bring necessary documents to airport"]
        let posts: [[String: Any]] = [data]
        UserDefaults.standard.set(posts, forKey: "posts")

        // Do any additional setup after loading the view.
//        let center = UNUserNotificationCenter.current()
        
        
        // set userdefaults
        UserDefaults.standard.set("testing", forKey: "test")
        
//        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//            print("\(key) = \(value) \n")
//        }
        
        // everything below here is reading/writing to a file
        
        /*** Save to project txt file ***/
        var fileURLProject = Bundle.main.url(forResource: "ProjectTextFile", withExtension: "txt")
        
//        print("FilePath: \(fileURLProject.path)")
        
        let writeString = "KEVIN ZHANG SAYS HE REALLY HATES SWIFT"
        do {
            // Write to the file
            try writeString.write(to: fileURLProject!, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURLProject), Error: " + error.localizedDescription)
        }
        
        /*** Read from project txt file ***/

        // File location
        var fileURLProject_2 = Bundle.main.path(forResource: "ProjectTextFile", ofType: "txt")
        print("step 1, file location")
        // Read from the file
        var readStringProject = ""
        do {
            readStringProject = try String(contentsOfFile: fileURLProject_2!, encoding: String.Encoding.utf8)
            print("step 2, read from file")
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURLProject_2), Error: " + error.localizedDescription)
        }

        print(readStringProject)
//
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
