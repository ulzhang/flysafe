//
//  ParentFeedViewController.swift
//  flysafe
//
//  Created by Kevin Zhang on 5/3/19.
//  Copyright © 2019 Kevin Zhang. All rights reserved.
//

import UIKit
//import Parse

class ParentFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: [[String: Any]] = UserDefaults.standard.value(forKey: "posts") as! [[String : Any]]
    //    UserDefaults.standard.set(data, forKey: "data")


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var numberLabel: UILabel!
    
    
    @IBAction func logoutButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("logged out from parent feed controller")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        //        tableView.backgroundColor = UIColor.black
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        posts = UserDefaults.standard.value(forKey: "posts") as! [[String : Any]]
        
        print("viewDidAppear")
        print(posts)
        print("viewDidAppear")
//        /*** Read from project txt file ***/
//
//        // File location
//        var fileURLProject_2 = Bundle.main.path(forResource: "ProjectTextFile", ofType: "txt")
//        print("step 1, file location")
//        // Read from the file
//        var readStringProject = ""
//        do {
//            readStringProject = try String(contentsOfFile: fileURLProject_2!, encoding: String.Encoding.utf8)
//            print("step 2, read from file")
//        } catch let error as NSError {
//            print("Failed reading from URL: \(fileURLProject_2), Error: " + error.localizedDescription)
//        }
//
//        print("made change to parent feed")
//        self.numberLabel.text = readStringProject
//
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]

//        let data: [String: Any] = ["status": "Check In to Flight",
//                                   "body":"Please remember to check in online and bring necessary documents to airport"]

        if (indexPath.row == 0){
            cell.backgroundColor = UIColor.white
        }
        else{
            cell.backgroundColor = UIColor.lightGray
        }
        print(post["status"] as! String)
        print(post["body"] as! String)
        cell.statusLabel.text = post["status"] as! String
        cell.bodyLabel.text = post["body"] as! String


        return cell
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
