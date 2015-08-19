//
//  Todo.swift
//  TodoList
//
//  Created by 王钊 on 15/8/19.
//  Copyright (c) 2015年 王钊. All rights reserved.
//

import Foundation

class Todo: NSObject {
    var id: String
    var image: String
    var title: String
    var date: NSDate
    
    init(id: String, image: String, title: String, date: NSDate) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}