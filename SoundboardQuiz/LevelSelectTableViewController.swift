//
//  LevelSelectTableViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 3/24/23.
//

import UIKit
import CoreData

class LevelSelectTableViewController: UITableViewController {

    var categories: [NSManagedObject] = []
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a Category"
     //   tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "category")
        configureFetchedResultsController()
     //   tableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func configureFetchedResultsController(){
        //get app's delegate (root object of app) to allow us to get the core data thread
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            print("ERROR: app delegate context not captured")
            return
        }
        //set sort descriptions, and feed our fetch results controller the request along with a managed object context (view context for us)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SoundCategory")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true) //ascending means alphabetically
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        //appDelegate viewContext is the context for reading data back to the view on the main thread (not UI thread)
        // not using backgroundContext because that is designed for operations that might take a while.
        fetchedResultsController?.delegate = self
        
        do{
            try fetchedResultsController?.performFetch()
            //attempts to find SoundCategory entities sorted by name
        }catch{
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = fetchedResultsController?.sections else{
            return 0
        }
        let rowCount = sections[section].numberOfObjects
        print("The amount of rows in the section are \(rowCount)")
        //return categories.count
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.RESUSE_IDENTIFIER, for: indexPath) as? CategoryTableViewCell
        else {
            return UITableViewCell();
        }
        //let category = categories[indexPath.row]
        if let soundCategory = fetchedResultsController?.object(at: indexPath) as? SoundCategory
        {
            print("NAME OF CATEGORY: \(soundCategory.name!)")
            if let categoryLabel = cell.catLabel{
             categoryLabel.text = soundCategory.name
            }
            //print(cell.self)
            //cell.categoryLabel?.text = category.value(forKeyPath: "name") as? String
        }
        // Configure the cell...
//        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.RESUSE_IDENTIFIER, for: indexPath) as! CategoryTableViewCell
//            cell.catLabel.text = "Done!"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSecondViewController()
    }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destVC = segue.destination as? MainGameViewController {
            if let senderCell = sender as? CategoryTableViewCell{
                //if let superView = senderCell.superview as? UITableView{
                let view = self.view as! UITableView
                let row = view.indexPath(for: senderCell)?.row
                
                destVC.setCategoryInfo(catName: "test", catFilename: "test2")
                
                //}
                
            }
        }
    }
    
    @IBAction func showSecondViewController() {
        print("test")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "MainGameScreen")

        show(secondVC, sender: self)
    }

}
extension LevelSelectTableViewController: NSFetchedResultsControllerDelegate{
    //methods called by fetched results controller when the data has changed in the managed object context that the controller is tracking
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("The controller content has changed.")
        tableView?.reloadData()
    }
}
//extension LevelSelectTableViewController: UITableViewDataSource {
    

//}
