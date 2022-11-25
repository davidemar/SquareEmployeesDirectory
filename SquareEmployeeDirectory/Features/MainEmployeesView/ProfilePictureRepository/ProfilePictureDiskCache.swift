//
//  ProfilePictureDiskCache.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/24/22.
//

import Foundation
import CoreData
import UIKit

class ProfilePictureDiskCache {

    static let imageStorageName = "ProfilePicture"
    
    lazy var container: NSPersistentContainer = {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        return container
    }()
    
    var repository: CoreDataImageRepository!
    
    init() {
        do {
            let storage = try ImageStorage(name: ProfilePictureDiskCache.imageStorageName)
            repository = CoreDataImageRepository(container: container, imageStorage: storage)
        } catch let error {
            Logger.shared.logError(error: error)
        }
    }
    
    func getImage(by id: String) -> UIImage? {
        return self.repository.findImage(by: id)
    }

    func storeImage(image: UIImage, withUrlString urlString: String) {
        if getImage(by: urlString) != nil {
            return
        }
        self.repository.makeImageStoredInFileSystem(image, urlString: urlString)
        self.container.viewContext.reset()
    }
    
}
