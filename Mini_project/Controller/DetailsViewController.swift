//
//  DetailsViewController.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 22/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController,UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var detail_log_dic = [String:[Double]]()
    
    var email:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailCell", bundle:nil), forCellReuseIdentifier: "ReusableCell")
        tableView.reloadData()
                
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail_log_dic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! DetailCell
        let firstKey = Array(detail_log_dic.keys)
        print( firstKey[indexPath.row])
        cell.DetailLabel.text! = firstKey[indexPath.row]
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

