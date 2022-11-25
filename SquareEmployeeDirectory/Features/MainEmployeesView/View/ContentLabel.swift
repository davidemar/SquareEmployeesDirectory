//
//  ContentLabel.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/25/22.
//

import Foundation
import UIKit

class ContentLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 14, weight: .light)
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
