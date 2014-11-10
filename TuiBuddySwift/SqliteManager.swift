//
//  SqliteManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 10/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class SqliteManager {
    // the database
    var _database: COpaquePointer = nil
    
    // MARK: - Shared instance
    
    class var sharedInstance: SqliteManager {
        struct Static {
            static var instance: SqliteManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = SqliteManager()
        }
        
        return Static.instance!
    }
    
    // MARK: - Construction and destruction
    
    init() {
        let dbPath: String! = NSBundle.mainBundle().pathForResource("attractions", ofType: "sqlite")
        if sqlite3_open((dbPath as NSString).UTF8String, &_database) != SQLITE_OK {
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
    
    func readAttractions() -> Array<Attraction> {
        var result = Array<Attraction>()
        // define sql query
        let query = "SELECT * FROM geofences"
        var statement:COpaquePointer = nil
        // prepare statement
        if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
            // iterate results
            while sqlite3_step(statement) == SQLITE_ROW {
                var attraction = Attraction()
                attraction.name = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(statement, 0)))!
                attraction.latitude = sqlite3_column_double(statement,1)
                attraction.longitude = sqlite3_column_double(statement,2)
                attraction.radius = sqlite3_column_double(statement,3)
                attraction.link = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(statement, 4)))!
                // add to result
                result.append(attraction)
            }
        }
        else {
            println("[***ERROR***] Failed to step statement: \(query)")
        }

        
        return result
    }
    
    func readAttraction(#name: String) -> Attraction? {
        var result = Attraction()
        // define sql query
        let query = "SELECT * FROM geofences WHERE name=\"\(name)\""
        var statement:COpaquePointer = nil
        // prepare statement
        if sqlite3_prepare_v2(_database, (query as NSString).UTF8String, -1, &statement, nil) == SQLITE_OK {
            // get the first (and supposedly only) result
            if sqlite3_step(statement) == SQLITE_ROW {
                // fill in dictionary
                result.name = name
                result.latitude = sqlite3_column_double(statement,1)
                result.longitude = sqlite3_column_double(statement,2)
                result.radius = sqlite3_column_double(statement,3)
                result.link = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(statement, 4)))!
                
            }
            else {
                println("[***ERROR***] Failed to step statement: \(query)")
            }
        }
        else {
            println("[***ERROR***] Failed to prepare statement: \(query)")
        }
        
        return countElements(result.name) > 0 ? result : nil
    }
}