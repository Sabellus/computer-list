//
//  PersistanceManager.swift
//  computer-list
//
//  Created by Савелий Вепрев on 10.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation
import CoreData


protocol PersistanceManagerProtocol {
    func save()
    func fetch<T: NSManagedObject> (_ objectType: T.Type) -> [T]
    func fetchBy<T>(_ objectType: T.Type, attribute: String, params: Int) -> [T]
    var persistentContainer: NSPersistentContainer { get set }
    var context: NSManagedObjectContext { get set }
}
class PersistanceManager: PersistanceManagerProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "computer_list")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
//                print("save success")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T>(_ objectType: T.Type) -> [T] where T : NSManagedObject {
        let entityName = String(describing: objectType)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        do {
            let fetchedObject = try context.fetch(fetchRequest) as? [T]
            
            return fetchedObject ?? [T]()
        }
        catch{
            print(error)
            return [T]()
        }
    }
    func fetchBy<T>(_ objectType: T.Type, attribute: String, params: Int) -> [T] {
        let entityName = String(describing: objectType)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "\(attribute) == %@", "\(params)")
        fetchRequest.predicate = predicate

        do {
            let fetchedObject = try context.fetch(fetchRequest) as? [T]
            
            return fetchedObject ?? [T]()
        }
        catch{
            print(error)
            return [T]()
        }
    }
}
