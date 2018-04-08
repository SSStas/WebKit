//
//  ViewController.swift
//  WebKit
//
//  Created by student on 08.04.2018.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    struct Metadata: Codable {
            let metadata: String
    }

    
    var petitions : [[String : String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.whitehouse.gov/v1/petitions.json?limit=1")!
        
        if let json = try? String(contentsOf: url) {
        
            let data = json.data(using: .utf8)!
            
            let decoder = JSONDecoder()
            let metadata = try! decoder.decode(Metadata.self, from: data)
            
            print(metadata)
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
        cell.textLabel?.text = "Заголовок"
        cell.detailTextLabel?.text = "Подзаголовоҝ"
        return cell
    }

}

