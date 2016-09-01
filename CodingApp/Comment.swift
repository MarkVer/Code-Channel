//
//  Comment.swift
//  CodingApp
//
//  Created by Rosa Meijers on 24-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class Comment: PFObject {
    
    
    override init() {
        super.init()
    }
    
    init(comment: String, user: PFUser) {
    super.init(className: "Comment")

    self["comment"] = comment
    self["user"] = user
    }
    
    
    
    
}
