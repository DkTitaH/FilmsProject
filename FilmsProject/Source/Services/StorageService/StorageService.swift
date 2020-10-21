//
//  StorageService.swift
//  FilmsProject
//
//  Created by iphonovv on 15.10.2020.
//

import Foundation
import CoreData

class CoreDataStorageService {
    
    enum Entity: String {
        case filmModel = "FilmModel"
    }

    private let persistentContainer: NSPersistentContainer
    private let managedContext: NSManagedObjectContext
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.managedContext = persistentContainer.viewContext
    }
        
    func save<T: Codable & CoreDataStorable>(model: T) {
        self.saveModel(model: model, { value in
            let data = try? JSONEncoder().encode(value)
            
            let dictionary = self.convertToDictionary(data: data) ?? [:]
            
            debugPrint(dictionary)
            
            return dictionary
        })
    }
    
    func delete<Model: Codable & CoreDataStorable>(
        type: Model.Type,
        by id: Int
    ) {
        self.delete(model: type, predicateFilter: "id == %@", value: id)
    }
    
    
    func delete<Model: Codable & CoreDataStorable>(model: Model.Type) -> Bool {
        let managedContext = self.managedContext
        let fetchRequest = Model.CoreDataModelType.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        return (try? managedContext.execute(deleteRequest)).map { _ in
            try? managedContext.save()
            
            return true
        } ?? false
    }
    
    private func saveModel<Model: Codable & CoreDataStorable>(
        model: Model,
        _ action: @escaping (Model) -> ([String: Any])
    ) {
        let managedContext = self.managedContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let entityValue = NSEntityDescription.entity(forEntityName: "\(Model.CoreDataModelType.self)", in: managedContext)!
        let article = NSManagedObject(entity: entityValue, insertInto: managedContext)
        article.setValuesForKeys(action(model))
        
        try? managedContext.save()
    }
    
    func fetch<Model: Codable & CoreDataStorable>(type: Model.Type) -> [Model] {
        let managedContext = self.managedContext
        let fetchRequest = NSFetchRequest<Model.CoreDataModelType>(entityName: "\(Model.CoreDataModelType.self)")
        
        
        let models = try? managedContext.fetch(fetchRequest)

        var success = [Model]()
        
        let data = self.convertToJSONArray(moArray: models ?? [])
        data.forEach { arr in
            if let jsonData = try? JSONSerialization.data(withJSONObject: arr, options: []) {
                if let jsonString = String(data: jsonData, encoding: .utf8)?.data(using: .utf8) {

                    switch Parser<Model>().object(from: jsonString) {
                    case let .success(model):
                        success.append(model)
                        debugPrint(model)
                    case let .failure(error):
                        debugPrint(error)
                    }
                }
            }
        }
        
        return success
    }
    
    private func delete<Model: Codable & CoreDataStorable>(model: Model.Type, predicateFilter: String, value: Any) {
        let managedContext = self.managedContext
        
        let fetchRequest = NSFetchRequest<Model.CoreDataModelType>(entityName: "\(Model.CoreDataModelType.self)")
        fetchRequest.predicate = NSPredicate(format: predicateFilter, argumentArray: [value])
        
        
        let object = (try? managedContext.fetch(fetchRequest))?.first
        object.map(managedContext.delete)
        
        try? managedContext.save()
    }
    
    private func convertToDictionary(data: Data?) -> [String: Any]? {
        if let data = data {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    private func convertToJSONArray(moArray: [NSManagedObject]) -> [[String: Any]] {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
    private func convertIntoJSONString(arrayObject: [String: Any]) -> String? {
        do {
            let jsonData: Data = try JSONSerialization.data(
                withJSONObject: arrayObject,
                options: []
                
            )
            if  let jsonString = NSString(
                data: jsonData,
                encoding: String.Encoding.utf8.rawValue
            ) {
                return jsonString as String
            }
            
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }
}
