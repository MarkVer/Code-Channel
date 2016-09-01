//
//  CommentClass.swift
//  CodingApp
//
//  Created by Rosa Meijers on 31-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class CommentClass: NSObject {
    
    var comment: String
    var user: String
    var userImage: PFFile
    
    init(comment: String, user: String, userImage: PFFile) {
        self.comment = comment
        self.user = user
        self.userImage = userImage
    }
    
    
    
}
