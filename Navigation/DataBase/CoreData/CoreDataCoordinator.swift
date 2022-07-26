//
//  CoreDataCoordinator.swift
//  Navigation
//
//  Created by Миша on 22.07.2022.
//

import Foundation
import CoreData

enum DatabaseError: Error {
    /// Невозможно добавить хранилище.
    case store(model: String)
    /// Не найден momd файл.
    case find(model: String, bundle: Bundle?)
    /// Не найдена модель объекта.
    case wrongModel
    /// Кастомная ошибка.
    case error(description: String)
    /// Неизвестная ошибка.
    case unknown(error: Error)
}


class CoreDataCoordinator {
    
    let modelName: String
    
    private let model: NSManagedObjectModel
    private let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    private lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
    init() throws{
        guard let url = Bundle.main.url(forResource: "PostsCoreData", withExtension: "momd") else {
            fatalError("Can't find data base - PostsCoreData")}
        
        let pathExtension = url.pathExtension
        
        guard let name = try? url.lastPathComponent.replace(pathExtension, replacement: "") else {
            print("Can't get name from URL")
            throw DatabaseError.error(description: "")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            print("Model isn't created")
            throw DatabaseError.error(description: "")
        }
        
        self.modelName = name
        self.model = model
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
    }
    
    
    static func create() -> Result<CoreDataCoordinator, DatabaseError> {
        do {
            let coordinator = try CoreDataCoordinator()
            return Self.setup(coordinator: coordinator)
        } catch let error as DatabaseError {
            return .failure(error)
        } catch {
            return .failure(.unknown(error: error))
        }
    }

    private static func setup(coordinator: CoreDataCoordinator) -> Result<CoreDataCoordinator, DatabaseError> {

        let storeCoordinator = coordinator.persistentStoreCoordinator

        let fileManager = FileManager.default
        let storeName = "\(coordinator.modelName)" + "sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let persistentStoreURL = documentsDirectoryURL?.appendingPathComponent(storeName)

        var databaseError: DatabaseError?
       
        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]

            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                    configurationName: nil,
                                                    at: persistentStoreURL,
                                                    options: options)
        } catch {
            databaseError = .store(model: coordinator.modelName)
        }

        if let error = databaseError {
            return .failure(error)
        }
        
        return .success(coordinator)
    }
}

extension CoreDataCoordinator {
    
    func create<T>(_ model: T.Type, keyedValues: [[String : Any]], completion: @escaping (Result<[T], DatabaseError>) -> Void) {
        
        self.mainContext.perform { [weak self] in
            guard let self = self else { return }

            var entities: [Any] = Array(repeating: true, count: keyedValues.count)
            
            keyedValues.enumerated().forEach { (index, keyedValues) in
                
                guard let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: model.self),
                                                                         in: self.mainContext)
                else {
                    completion(.failure(.wrongModel))
                    return
                }
                
                let entity = NSManagedObject(entity: entityDescription,
                                             insertInto: self.mainContext)
                
                entity.setValuesForKeys(keyedValues)
                entities[index] = entity
            }
            
            guard let objects = entities as? [T] else {
                completion(.failure(.wrongModel))
                return
            }
            
            guard self.mainContext.hasChanges else {
                completion(.failure(.store(model: String(describing: model.self))))
                return
            }
            
            do {
                try self.mainContext.save()
                completion(.success(objects))
            } catch let error {
                completion(.failure(.error(description: "Unable to save changes of main context.\nError - \(error.localizedDescription)")))
            }
        }
    }

    func delete<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseError>) -> Void) {
        self.fetch(model, predicate: predicate) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fetchedObjects):
                guard let fetchedObjects = fetchedObjects as? [NSManagedObject] else {
                    completion(.failure(.wrongModel))
                    return
                }

                self.mainContext.perform {
                    fetchedObjects.forEach { fetchedObject in
                        self.mainContext.delete(fetchedObject)
                    }
                    let deletedObjects = fetchedObjects as? [T] ?? []

                    guard self.mainContext.hasChanges else {
                        completion(.failure(.store(model: String(describing: model.self))))
                        return
                    }

                    do {
                        try self.mainContext.save()
                        completion(.success(deletedObjects))
                    } catch let error {
                        completion(.failure(.error(description: "Unable to save changes of main context.\nError - \(error.localizedDescription)")))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseError>) -> Void) {
        guard let model = model as? NSManagedObject.Type else {
            completion(.failure(.wrongModel))
            return
        }
        
        self.mainContext.perform {
            let request = model.fetchRequest()
            request.predicate = predicate
            guard
                let fetchRequestResult = try? self.mainContext.fetch(request),
                let fetchedObjects = fetchRequestResult as? [T]
            else {
                completion(.failure(.wrongModel))
                return
            }
            
            completion(.success(fetchedObjects))
        }
    }
    
    func fetchAll<T>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseError>) -> Void) {
        self.fetch(model, predicate: nil, completion: completion)
    }
}

