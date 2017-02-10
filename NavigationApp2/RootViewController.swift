//
//  RootViewController.swift
//  NavigationApp2
//
//  Created by andrey on 2/9/17.
//  Copyright © 2017 andrey. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    //add
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoritesList: FavoritesList!
    private static let familyCell = "FamilyName"
    private static let favoritesCell = "Favorites"
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add
        familyNames = (UIFont.familyNames as [String]).sorted()
        let preferredTableViewFont =
            UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoritesList
        tableView.estimatedRowHeight = cellPointSize
        //

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    
    //add
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNames(forFamilyName: familyName).first
            return fontName != nil ?
                UIFont(name: fontName!, size: cellPointSize) : nil
        } else {
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return favoritesList.favorites.isEmpty ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    //
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // The font names list
            let cell = tableView.dequeueReusableCellWithIdentifier(
                RootViewController.familyCell,
                forIndexPath: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        } else {
            // The favorites list
            return tableView.dequeueReusableCellWithIdentifier(
                RootViewController.favoritesCell,
                forIndexPath: indexPath)
        }
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // The font names list
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RootViewController.familyCell,
                for: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        } else {
            // The favorites list
            return tableView.dequeueReusableCell(
                withIdentifier: RootViewController.favoritesCell,
                for: indexPath)
        }
    }
    
    

 
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //add
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let listVC = segue.destination as! FontListViewController
        
        if indexPath.section == 0 {
            // Font names list
            let familyName = familyNames[indexPath.row]
            //listVC.fontNames = (UIFont.fontNamesForFamilyName(familyName) as [String]).sort()
            listVC.fontNames = (UIFont.fontNames(forFamilyName: familyName) as [String]).sorted()
            listVC.navigationItem.title = familyName
            listVC.showsFavorites = false
        } else {
            // Favorites list
            listVC.fontNames = favoritesList.favorites
            listVC.navigationItem.title = "Favorites"
            listVC.showsFavorites = true
        }
        //
    }
    

}
