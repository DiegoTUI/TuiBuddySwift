//
//  SqliteManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 10/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import UIKit

class AttractionManager {
    // the database
    var _database: COpaquePointer = nil
    
    // MARK: - Shared instance
    
    class var sharedInstance: AttractionManager {
        struct Static {
            static var instance: AttractionManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = AttractionManager()
        }
        
        return Static.instance!
    }
    
    // MARK: - Construction and destruction
    
    init() {
        // copy the db to writable file system and open it
        let dbPath: String! = NSBundle.mainBundle().pathForResource(config.sqliteDbName, ofType: "sqlite")
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let writableDbPath = "\(documentsPath)/\(config.sqliteDbName).sqlite"
        // copy the db file if it doesn't exist
        if !NSFileManager.defaultManager().fileExistsAtPath(writableDbPath) {
            var error: NSError? = nil
            if (!NSFileManager.defaultManager().copyItemAtPath(dbPath, toPath: writableDbPath, error: &error)) {
                println("[***ERROR***] Failed to create writable database file with message \(error!.localizedDescription)")
            }
        }
        if sqlite3_open((writableDbPath as NSString).UTF8String, &_database) != SQLITE_OK {
            println("[***ERROR***] Failed to open database")
        }
        else {
            println("Database open")
        }
        
    }
    
    deinit {
        if sqlite3_close(_database) != SQLITE_OK {
            println("[***ERROR***] Problem closing database")
        }
        _database = nil;
    }
    
    // MARK: - Read
    
    func readAttractions() -> [Attraction] {
        var result = Array<Attraction>()
        // grab cms contents and complete with latitude/longitude/radius from the DB
        let cmsItemIterator = CmsManager.sharedInstance.cmsItemIterator()
        // get first item and iterate
        var cmsItem: NSDictionary? = cmsItemIterator.current()
        while let cmsAttraction = cmsItem  {
            // get the variables to build the attraction
            let id: String = cmsAttraction["attractionId"] as String
            let name: String = cmsAttraction["attractionName"] as String
            let text: String = cmsAttraction["attractionText"] as String
            // now facts
            var facts = Array<Fact>()
            let cmsFacts: NSArray = cmsAttraction["facts"] as NSArray
            for fact in cmsFacts {
                let factAsDictionary: NSDictionary = fact as NSDictionary
                var factToInsert = Fact(id: factAsDictionary["factId"] as String,
                    name: factAsDictionary["factTitle"] as String,
                    text: factAsDictionary["factText"] as String)
                // set fact image
                factToInsert.imageName = "fact_\(id)_\(factToInsert.id)"
                facts.append(factToInsert)
            }
            // get latitude, longitude and radius from sqlite
            var latitude: Double = kInvalidDouble
            var longitude: Double = kInvalidDouble
            var radius: Double = kInvalidDouble
            
            let query = "SELECT * FROM \(config.sqliteTableName) WHERE attractionId=?"
            var statement:COpaquePointer = nil
            // prepare statement
            if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, id, -1, nil)
                // get the only result
                if sqlite3_step(statement) == SQLITE_ROW {
                    latitude = sqlite3_column_double(statement,1)
                    longitude = sqlite3_column_double(statement,2)
                    radius = sqlite3_column_double(statement,3)
                }
            }
            else {
                println("[***ERROR***] Failed to step statement: \(query)")
            }
            result.append(Attraction(id: id, name: name, text: text, latitude: latitude, longitude: longitude, radius: radius, facts: facts))
            // iterate
            cmsItem = cmsItemIterator.next()
        }
        
        return result
    }
    
    
    // MARK: - Update - We only update latitude, longitude and radius
    
    func updateAttraction(attraction: Attraction) {
        // define sql query
        let query = "UPDATE \(config.sqliteTableName) SET latitude=?, longitude=?, radius=? WHERE attractionId=?"
        var statement:COpaquePointer = nil
        // prepare statement
        if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_double(statement, 1, attraction.latitude)
            sqlite3_bind_double(statement, 2, attraction.longitude)
            sqlite3_bind_double(statement, 3, attraction.radius)
            sqlite3_bind_text(statement, 4, (attraction.id as NSString).UTF8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                statement = nil
            }
            else {
                println("[***ERROR***] Failed to step statement: \(query)")
            }
        }
        else {
            println("[***ERROR***] Failed to prepare statement: \(query)")
        }
    }
}