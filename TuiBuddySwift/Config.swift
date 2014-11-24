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
    let debug = true
    // fakeCMS
    var fakeCMS = "attractions"
}

var config = _Config()