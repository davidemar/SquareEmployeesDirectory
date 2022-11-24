//
//  EmployeeTableViewCell.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = String(describing: EmployeeTableViewCell.self)
    
    lazy var rightImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rightImage)
        NSLayoutConstraint.activate([
            rightImage.topAnchor.constraint(equalTo: topAnchor),
            rightImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightImage.rightAnchor.constraint(equalTo: rightAnchor),
            rightImage.widthAnchor.constraint(equalTo: rightImage.heightAnchor)
        ])
    }
    
    func setupCell(image: String) {
        rightImage.image = UIImage(named: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
