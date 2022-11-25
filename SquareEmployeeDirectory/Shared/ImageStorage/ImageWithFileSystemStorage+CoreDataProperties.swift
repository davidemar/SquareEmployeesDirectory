//
//  ImageWithFileSystemStorage+CoreDataProperties.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/24/22.
//

import Foundation
import CoreData

extension ImageWithFileSystemStorage {
    @nonobjc public class func fetchRequest(by urlString: String) -> NSFetchRequest<ImageWithFileSystemStorage> {
        let fetchRequest = NSFetchRequest<ImageWithFileSystemStorage>(entityName: "ImageWithFileSystemStorage")
        fetchRequest.predicate = NSPredicate(
            format: "urlString LIKE %@", urlString
        )
        return fetchRequest
    }

    @NSManaged public var urlString: String?

}
