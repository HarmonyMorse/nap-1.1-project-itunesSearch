//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Harm on 5/2/23.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTypeSegmentedController: UISegmentedControl!
    
    let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        var resultType: ResultType!
        
        switch resultTypeSegmentedController.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchText, resultType: resultType) { error in
            if let error = error {
                print("Error performing search: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    /*
         // Perform the search
         searchResultsController.performSearch(for: searchText, resultType: resultType) { error in
             if let error = error {
                 print("Error performing search: \(error)")
             } else {
                 DispatchQueue.main.async {
                     self.tableView.reloadData()
                 }
             }
         }
     }
 }
*/

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        if let title = searchResult.title {
            cell.textLabel?.text = title
        } else if let collectionName = searchResult.collectionName {
            cell.textLabel?.text = collectionName
        } else {
            print("no title or collection name")
        }
        
        cell.detailTextLabel?.text = searchResult.creator
        cell.detailTextLabel?.textColor = UIColor.gray
        
        return cell
    }
    
    /*let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as! PersonTableViewCell
     
     // Configure the cell...
     let person = personController.people[indexPath.row]
     cell.nameLabel.text = person.name
     cell.heightLabel.text = "\(person.height) cm"
     cell.birthYearLabel.text = "Born \(person.birthYear)"
     return cell*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
