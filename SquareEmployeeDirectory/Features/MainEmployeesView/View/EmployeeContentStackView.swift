//
//  EmployeeContentStackView.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/25/22.
//

import Foundation
import UIKit

class EmployeeContentStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 0
        alignment = .fill
        distribution = .equalSpacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//class EmployeeTableViewCell: UITableViewCell {
//
//    static let reuseIdentifier: String = String(describing: EmployeeTableViewCell.self)
//}
