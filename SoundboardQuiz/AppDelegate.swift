//
//  AppDelegate.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 2/28/23.
//

import UIKit
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let manualLoadDataFromPlist = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do{
                try preloadData()
        }catch{
            print(error)
        }
        print("Application directory: \(NSHomeDirectory())")

        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // MARK: - Core Data stack

    public lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func preloadData() throws{
        let preloadedDataKey = "didPreloadData"
        let userDefaults = UserDefaults.standard
        if(userDefaults.bool(forKey: preloadedDataKey) == false || manualLoadDataFromPlist){
            
            userDefaults.set(true, forKey: preloadedDataKey)
            guard let urlPath = Bundle.main.url(forResource: "PreloadedData", withExtension: "plist")
            else{
                //if the file is null, return. This should never happen!
                print("ERROR: plist file not found")
                return
            }
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

            let arrayContents = try NSArray(contentsOf: urlPath, error: ())
                //as? [Dictionary<Key: String, Dictionary<Key: >>]
            
            //to run this block of code in another thread to simulate a delay, can use:
            //DispatchQueue.main.asyncAfter(deadline: .now() + 6){}
            
            backgroundContext.perform {
                do{
                    
                
                for item in arrayContents{
                    if let myItem = item as? NSArray{
                        var currentCategoryObject: SoundCategory?
                        for listVal in myItem{
                            if listVal is NSDictionary{
                                let dict = (listVal as! NSDictionary) as! Dictionary<String, String>
                                //THIS DICTIONARY CONTAINS KEY VALUE PAIRS FOR NAME OF SOUND + SOUND FILE NAME
                                if let currentCategoryObject{
                                    for (soundName, soundFile) in dict{
                                        let soundObject = Sound(context: backgroundContext)
                                        soundObject.name = soundName
                                        soundObject.file = soundFile
                                        soundObject.parentCategory = currentCategoryObject
                                        print("\(soundName), \(soundFile)")
                                    }
                                }else{
                                    print("ERROR: no associated category object has been initialized")
                                }


                            }else if listVal is NSString {
                                let strItem = listVal as! NSString
                                //THIS IS THE NAME OF THE CATEGORY
                                print(strItem)
                            
                                let soundCategoryObject = SoundCategory(context: backgroundContext)
                                soundCategoryObject.name = String(strItem)
                                currentCategoryObject = soundCategoryObject

                                
                            }//https://www.youtube.com/watch?v=hrwx_teqwdQ
                        }

                    }

                }
                    try backgroundContext.save()
                } catch {
                        print(error.localizedDescription)
                }

            }
        
            //preload data complete

        }else{
            print("Data has already been imported.")
        }
    }
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        
//    }
    func applicationWillTerminate(_ application: UIApplication) {
        do{
            try MainGameViewController.attemptSaveState()
        } catch{
            print(error.localizedDescription)
            // We are not currently in the middle of a game, so we can safely exit
            UserDefaults.standard.removeObject(forKey: "lastState")
        }
        
    }



}

