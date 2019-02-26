//
//  SearchViewController.swift
//  NaviMatchin
//
//  Created by Kento Katsumata on 2019/02/26.
//  Copyright © 2019 hiropon. All rights reserved.
//

import UIKit
import MessageUI

class SearchViewController: UIViewController, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var matchingResults = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text != ""{
            
            EZFirebaseByKenty.Search.search(placeName: searchBar.text!) { (status) in
                print(status!)
                self.matchingResults = status as! [[String]]
                self.tableView.reloadData()
            }
            self.searchBar.endEditing(true)
        }
        
    }
    
    
    
    //conform to protocol
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingResults.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableView", for: indexPath) as! SearchTableViewCell
        cell.firstName.text = "\(matchingResults[indexPath.row][0]) \(matchingResults[indexPath.row][1])"
        cell.descriptionLabel.text = "\(matchingResults[indexPath.row][2])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MFMailComposeViewController.canSendMail() {
            let mailer = MFMailComposeViewController()
            mailer.mailComposeDelegate = self
            mailer.setToRecipients([matchingResults[indexPath.row][3]])
            mailer.setSubject("Navi Machinで出会いました") // 件名
            mailer.setMessageBody("", isHTML: false) // 本文
            self.present(mailer, animated: true, completion: nil)
        } else {
            print("送信できません")
        }
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }
        dismiss(animated: true, completion: nil)
    }
}
