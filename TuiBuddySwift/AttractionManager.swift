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
        let dbPath: String! = NSBundle.mainBundle().pathForResource("attractions", ofType: "sqlite")
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let writableDbPath = "\(documentsPath)/attractions.sqlite"
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
        // define sql query
        let query = "SELECT rowid,* FROM geofences"
        var statement:COpaquePointer = nil
        // prepare statement
        if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
            // iterate results
            while sqlite3_step(statement) == SQLITE_ROW {
                var attraction = Attraction()
                attraction.id = sqlite3_column_int(statement, 0)
                attraction.name = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(statement, 1)))!
                attraction.latitude = sqlite3_column_double(statement,2)
                attraction.longitude = sqlite3_column_double(statement,3)
                attraction.radius = sqlite3_column_double(statement,4)
                attraction.url = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(statement, 5)))!
                // add to result
                result.append(attraction)
            }
        }
        else {
            println("[***ERROR***] Failed to step statement: \(query)")
        }

        return result
    }
    
    
    // MARK: - Write/Update
    
    func writeAttraction(attraction: Attraction) {
        // define sql query
        let query = "INSERT INTO geofences(name, latitude, longitude, radius, link) VALUES(?, ?, ?, ?, ?)"
        var statement:COpaquePointer = nil
        // prepare statement
        if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (attraction.name as NSString).UTF8String, -1, nil)
            sqlite3_bind_double(statement, 2, attraction.latitude)
            sqlite3_bind_double(statement, 3, attraction.longitude)
            sqlite3_bind_double(statement, 4, attraction.radius)
            sqlite3_bind_text(statement, 5, (attraction.url as NSString).UTF8String, -1, nil)
            
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
    
    func updateAttraction(attraction: Attraction) {
        // define sql query
        let query = "UPDATE geofences SET name=?, latitude=?, longitude=?, radius=?, link=? WHERE rowid=?"
        var statement:COpaquePointer = nil
        // prepare statement
        if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (attraction.name as NSString).UTF8String, -1, nil)
            sqlite3_bind_double(statement, 2, attraction.latitude)
            sqlite3_bind_double(statement, 3, attraction.longitude)
            sqlite3_bind_double(statement, 4, attraction.radius)
            sqlite3_bind_text(statement, 5, (attraction.url as NSString).UTF8String, -1, nil)
            sqlite3_bind_int(statement, 6, attraction.id)
            
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
    
    // MARK: - Delete
    
    func deleteAttraction(attraction: Attraction) {
        // define sql query
        let query = "DELETE FROM geofences WHERE name=\"\(attraction.name)\""
        var statement:COpaquePointer = nil
        // prepare statement
        if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
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