//
//  Extensions.swift
//  demo
//
//  Created by macbookpro on 19/9/2021.
//

import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
}

//enum CellModel {
//    case collectionView(models: [CollectionTableCellModel])
//    case list(models: [ListCellModel])
//}
//
//struct ListCellModel{
//    let title: String
//}
//
//struct CollectionTableCellModel {
//    let title: String
//    let imageName: String
//}

struct User {
    static let username : String = "ABC"
}

struct Users {
    let name: String
}

struct Group {
    let id: String
    let max: String
    let name: String
    let createUser: String
    
}
