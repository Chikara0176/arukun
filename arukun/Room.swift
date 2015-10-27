//
//  Room.swift
//  arukun
//
//  Created by 坂本一 on 2015/10/26.
//  Copyright (c) 2015年 chikaratada. All rights reserved.
//

import Foundation
import CoreData

@objc(Room)
class Room: NSManagedObject {

    @NSManaged var background: NSNumber
    @NSManaged var fur1: NSNumber
    @NSManaged var fur2: NSNumber
    @NSManaged var fur3: NSNumber
    @NSManaged var fur4: NSNumber

}

@objc(Pet)
class Pet: NSManagedObject {
    
    @NSManaged var b: NSNumber
    @NSManaged var ended: NSDate
    @NSManaged var g: NSNumber
    @NSManaged var generation: NSNumber
    @NSManaged var name: String
    @NSManaged var r: NSNumber
    @NSManaged var started: NSDate
    @NSManaged var totaldistance: NSNumber
    @NSManaged var totalstep: NSNumber
    
}

@objc(Pedometer)
class Pedometer: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var step: NSNumber
    
}

@objc(Charapicture)
class Charapicture: NSManagedObject {
    
    @NSManaged var number: NSNumber
    @NSManaged var picturename: String
    @NSManaged var picturenumber: NSNumber
    
}

@objc(Word)
class Word: NSManagedObject {
    
    @NSManaged var kind: NSNumber
    @NSManaged var text: String
    
}

@objc(Diary)
class Diary: NSManagedObject {
    
    @NSManaged var text: String
    @NSManaged var writeat: NSDate
    
}

@objc(User)
class User: NSManagedObject {
    
    @NSManaged var money: NSNumber
    @NSManaged var stature: NSNumber
    @NSManaged var stride: NSNumber
    
}

@objc(Charadata)
class Charadata: NSManagedObject {
    
    @NSManaged var rank: NSNumber
    @NSManaged var rgb: String
    
}



