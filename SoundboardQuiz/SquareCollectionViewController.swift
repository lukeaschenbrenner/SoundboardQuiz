//
//  SecondGameViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/21/23.
//

import UIKit

class SquareCollectionViewController: UICollectionViewController, UICollectionViewDragDelegate, UICollectionViewDropDelegate  {
    //UIViewController, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UICollectionViewDataSource, UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
    
    //MARK: - Collection Setup
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type(of: collectionView) == ImageCollectionViewCell.self {
            return 4
        }else{
            return 5-1//4
        }
    }
    var sounds: [Sound]?
    var currentIndex: Int = 0
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if type(of: collectionView) == ImageCollectionView.self{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.REUSE_IDENTIFIER, for: indexPath)
            return cell
        }else if type(of: collectionView) == SoundCollectionView.self{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundCollectionViewCell.REUSE_IDENTIFIER, for: indexPath) as! SoundCollectionViewCell
            if(sounds == nil){
                do{
                    try sounds = (self.parent as! MainGameViewController).sounds?.sorted(by: {(firstSound, secondSound) throws -> Bool in return firstSound.name ?? "" > secondSound.name ?? ""})

                }catch{
                    print(error.localizedDescription)
                }
            }

            cell.label.text = sounds?[currentIndex].name ?? "error nil"
            if(currentIndex >= (sounds!.count - 1)){
                currentIndex = 0
            }else{
                currentIndex = (sounds?.index(after: currentIndex)) ?? 0

            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundCollectionViewCell.REUSE_IDENTIFIER, for: indexPath)
            return cell
        }
    }
    
    
    
    //private var isDragging = false
    
//    @IBOutlet var imagesView: UICollectionView!
//    @IBOutlet var soundsView: UICollectionView!
    //    private let myView: UIView = {
    //        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    //        view.backgroundColor = .link
    //        view.isUserInteractionEnabled = true;
    //        return view
    //    }()
    
    override func viewDidLoad() {
      //  imagesView.dragDelegate = self
      //  soundsView.dragDelegate = self
        
      //  imagesView.dropDelegate = self
       // soundsView.dropDelegate = self
        self.collectionView.dragDelegate = self
        self.collectionView.dropDelegate = self
        self.collectionView.dragInteractionEnabled = true
        self.collectionView.reorderingCadence = .fast
       // imagesView.dragInteractionEnabled = true
        //soundsView.dragInteractionEnabled = true
        
      //  imagesView.reorderingCadence = .fast
      //  soundsView.reorderingCadence = .fast
        
      //  imagesView.dataSource = self
      //  soundsView.dataSource = self
        
       // imagesView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.REUSE_IDENTIFIER)
        
      //  soundsView.register(SoundCollectionViewCell.self, forCellWithReuseIdentifier: SoundCollectionViewCell.REUSE_IDENTIFIER)
        
        
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        myView.center = view.center
    }
    
//    var oldX: CGFloat = 0;
//    var oldY: CGFloat = 0;
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    //var items: [String] = [String](repeating: "Hello", count: 4)
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        let theString = (collectionView.cellForItem(at: indexPath) as! SoundCollectionViewCell).label.text
        let itemProvider = NSItemProvider(object: theString! as NSString)
        //        let itemProvider = NSItemProvider(item: theString as NSData, typeIdentifier: UTType.plainText.identifier)
        
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = theString
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if session.localDragSession != nil // the drag session began in the current app (otherwise this makes no sense!)
        {
            if collectionView.hasActiveDrag
            { // the item was dragged into the current collection view, in which case we don't want to deal with it
                return UICollectionViewDropProposal(operation: .cancel, intent: .insertIntoDestinationIndexPath)
            }
            else
            {
                // ITEM HAS BEEN DROPPED
                // TODO: GREY OUT COLLECTION VIEW ITEM HERE
                return UICollectionViewDropProposal(operation: .copy, intent: .insertIntoDestinationIndexPath)
            }
        }
        else
        {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    //Also, when incorporating items, use drop(_:to:) or drop(_:toItemAt:) methods of the coordinator object to animate the transition from the drag item's preview to the corresponding item in your collection view.
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
        else
        {
            // Get last index path of collection view.
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation
        {
        case .move:
            //We should never need to run this code
            break
            
        case .copy:
            collectionView.performBatchUpdates({
                var indexPaths = [IndexPath]()
                for (index, item) in coordinator.items.enumerated()
                {
                    //Destination index path for each item is calculated separately using the destinationIndexPath fetched from the coordinator
                    let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
              //      items.insert(item.dragItem.localObject as! String, at: indexPath.row)
                    indexPaths.append(indexPath)
                   // coordinator.drop(item, to: <#T##UICollectionViewDropPlaceholder#>)

                }
                collectionView.insertItems(at: indexPaths)
            })
            
            break
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?
    {
        let previewParameters = UIDragPreviewParameters()
        previewParameters.visiblePath = UIBezierPath(rect: CGRect(x: 25, y: 25, width: 120, height: 120))
        return previewParameters
    }
    
}
    // MARK: - Touches
    
    //extension SecondGameViewController{
    //
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        guard let touch = touches.first else {
    //            return
    //        }
    //        let location = touch.location(in: self.view)
    //
    //        oldX = location.x
    //        oldY = location.y
    //     //   if myView.bounds.contains(location){
    //     //      // print("did touch in blue view")
    //      //      isDragging = true;
    //      //  }
    //    }
    //
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        guard isDragging else{
    //            return;
    //        }//only continues if they are dragging right now, similar to an assert
    //        guard let touch = touches.first else{
    //            return
    //        }
    //        //NOTE: use oldX and oldY to avoid view clipping directly to center
    //        let location = touch.location(in: view) //get the location in the larger container view
    //    //    myView.frame.origin.x = location.x - (myView.frame.size.width / 2)
    //   //     myView.frame.origin.y = location.y - (myView.frame.size.height / 2)
    //    }
    //
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        isDragging = false
    //    }
    //}
    

