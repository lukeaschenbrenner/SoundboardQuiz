//
//  GameViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/21/23.
//
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class GameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    
    var leftTableView = UITableView()
    var rightTableView = UITableView()
    
    var leftItems = [String](repeating: "Left", count: 20)
    var rightItems = [String](repeating: "Right", count: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTableView.dataSource = self
        rightTableView.dataSource = self
        
        leftTableView.frame = CGRect(x: 0, y: 40, width: 150, height: 400)
        rightTableView.frame = CGRect(x: 150, y: 40, width: 150, height: 400)
        
        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        
        leftTableView.dragDelegate = self
        leftTableView.dropDelegate = self
        rightTableView.dragDelegate = self
        rightTableView.dropDelegate = self
        
        leftTableView.dragInteractionEnabled = true
        rightTableView.dragInteractionEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftItems.count
        } else {
            return rightItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if tableView == leftTableView {
            cell.textLabel?.text = leftItems[indexPath.row]
        } else {
            cell.textLabel?.text = rightItems[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let string = tableView == leftTableView ? leftItems[indexPath.row] : rightItems[indexPath.row]
        guard let data = string.data(using: .utf8) else { return [] } // in order to drag and drop, we must convert our string into a Data object
        let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: UTType.plainText.identifier) // as? String (maybe??)

        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

        guard let destinationIndexPath = coordinator.destinationIndexPath
        else{
            return
        }


        //else {
//            // They placed the cell in whitespace, maybe animate it moving back?
//            //let section = tableView.numberOfSections - 1
//            //let row = tableView.numberOfRows(inSection: section)
//
//            //destinationIndexPath = IndexPath(row: row, section: section)
//            destinationIndexPath = nil;
//        }
        //let destIndy = destinationIndexPath!
        // We have recieved a drop request, so we should try to load the data that was dropped
        coordinator.session.loadObjects(ofClass: NSString.self, completion: ({(items: [NSItemProviderReading]) -> Void in
            
            guard let strings = items as? [String]
                else {
                print("Error: dropped items are supposed to be of clas NSString, but the dropped items don't conform to String!")
                return
            }

            // create an empty array to track rows we've copied
            var indexPaths = [IndexPath]()

            // loop over all the strings we received
            for (index, string) in strings.enumerated() {
                // create an index path for this new row, moving it down depending on how many we've already inserted
                let indexPath: IndexPath = IndexPath(row: (destinationIndexPath.row) + index, section: destinationIndexPath.section)
                
                // insert the copy into the correct array
                if tableView == self.leftTableView {
                    self.leftItems.insert(string, at: indexPath.row)
                } else {
                    self.rightItems.insert(string, at: indexPath.row)
                }
                // keep track of this new row
                indexPaths.append(indexPath)
                

            }
            
            // insert them all into the table view at once
            tableView.insertRows(at: indexPaths, with: .automatic)
        
            
        }))
                                   
    }
}
/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/

