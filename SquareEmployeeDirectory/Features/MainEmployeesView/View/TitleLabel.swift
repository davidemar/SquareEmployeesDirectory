//
//  TitleLabel.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/25/22.
//

import Foundation
import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
