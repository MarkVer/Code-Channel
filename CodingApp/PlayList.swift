//
//  PlayList.swift
//  CodingApp
//
//  Created by Sjoerd on 17-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation


class PlayList : NSObject {

    var name: String
    var image: UIImage
    var level: String
    var OS: String
    var planguage: String
    
    
    init(name: String, image: UIImage, levellabel: String, OSlabel: String, planguageLabel: String) {

        self.name = name
        self.image = image
        self.level = levellabel
        self.OS =  OSlabel
        self.planguage = planguageLabel
        

    }

}

