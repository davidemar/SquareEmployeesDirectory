//
//  EmployeeViewModel.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//

import Foundation
import UIKit

class EmployeeViewModel {
    var id: String
    var name: String
    var phoneNumber: String?
    var email: String
    var biography: String?
    
    var photo: UIImage? {
        didSet {
            reloadView?()
        }
    }
    
    var profilePhotoURL: String?
    
    var team: String
    var employeeType: EmployeeType
    var reloadView: (() -> Void)?
    
    private var profilePictureRepository: ProfilePictureRepositoryProtocol?
    
    init(employee: Employee,
         profilePictureRepository: ProfilePictureRepositoryProtocol) {
        self.id = employee.id
        self.name = employee.name
        self.phoneNumber = employee.phoneNumber
        self.email = employee.email
        self.biography = employee.biography
        self.team = employee.team
        self.employeeType = employee.employeeType
        self.profilePictureRepository = profilePictureRepository
        profilePhotoURL = employee.photoUrlSmall
    }
    
    func setupImage() {
        profilePictureRepository?.downloadImage(withImageUrlString: profilePhotoURL,
                                                placeholderImage: UIImage(named: "EmptyUserIcon"),
                                                completionHandler: {[weak self] image, errorFound in
            guard let self = self else { return}
            DispatchQueue.main.async {
                self.photo = image
            }
        })
    }
}
