//
//  AppDelegate.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
        -> Bool
    {
        let builder = URLBuilder()
        let networkService = NetworkServiceConnectivity()
        
        let requestService = APIService(
            session: .init(
                configuration: .default,
                delegate: nil,
                delegateQueue: nil
            ),
            urlBuilder: builder
        )
        
        let storageService = CoreDataStorageService(
            persistentContainer: self.persistentContainer
        )
        
        let coordinator = AppCoordinator(
            requestService: requestService,
            networkService: networkService,
            storageService: storageService
        )
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = coordinator
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
