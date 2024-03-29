//
//  Config.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 13/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

struct _Config {
    // should show alerts when entering a region in foreground?
    let showAlerts = true
    // are we in debug mode?
    let debug = false
    // fakeCMS
    var fakeCMS = "attractions"
    // sqlite db and table names
    var sqliteDbName = "attractions"
    var sqliteTableName = "attractions"
}

var config = _Config()