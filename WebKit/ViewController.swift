//
//  ViewController.swift
//  WebKit
//
//  Created by student on 08.04.2018.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    struct Petitions : Codable {
        let metadata: Metadata
        let results: [Result]
    }
    
    struct Metadata: Codable {
        let responseInfo: ResponseInfo
    }
    
    struct ResponseInfo: Codable {
        let status: Int
    }
    
    struct Result: Codable {
        let title:String
        let body: String
    }
    
    var petitions : [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.whitehouse.gov/v1/petitions.json?limit=100")!
        
        if let json = try? String(contentsOf: url) {
            let inputData = json.data(using: .utf8)!
            let decoder = JSONDecoder()
            if let petitionList = try? decoder.decode(Petitions.self, from: inputData) {
                if 200...299 ~= petitionList.metadata.responseInfo.status{
                    petitions = petitionList.results
                }
            }
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ TableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(petitions[indexPath.row].title)"
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }

}

