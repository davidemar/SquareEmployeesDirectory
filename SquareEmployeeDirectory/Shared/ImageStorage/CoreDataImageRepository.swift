//
//  ImageDAO.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/24/22.
//

import CoreData
import class UIKit.UIImage

/// This Core Data Repository manage the ImageWithFileSystemStorage MO objects
/// This ImageWithFileSystemStorage is associated with a URL that then is looked in Image storage to get the actual image from File Systems
class CoreDataImageRepository {
    
    private let container: NSPersistentContainer
    private let imageStorage: ImageStorageProtocol

    init(container: NSPersistentContainer, imageStorage: ImageStorageProtocol) {
        self.container = container
        self.imageStorage = imageStorage
    }

    func makeImageStoredInFileSystem(_ bitmap: UIImage, urlString: String?) {
        let image = insert(ImageWithFileSystemStorage.self, into: container.viewContext)
        image.storage = imageStorage
        image.image = bitmap
        image.urlString = urlString
        saveContext()
    }
    
    func findImage(by id: String) -> UIImage? {
        let fetchRequest: NSFetchRequest<ImageWithFileSystemStorage> = ImageWithFileSystemStorage.fetchRequest(by: id)
        let image: ImageWithFileSystemStorage?
        do {
            let images = try container.viewContext.fetch(fetchRequest)
            image = images.first
            image?.storage  = imageStorage
            return image?.image
        } catch let error {
            Logger.shared.logError(error: error)
            return nil
        }
    }

    private func saveContext() {
        do {
            try container.viewContext.save()
        } catch let error {
            Logger.shared.logError(error: error)
        }
    }

    private func insert<T>(_ type: T.Type, into context: NSManagedObjectContext) -> T {
        return NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
    }
}

