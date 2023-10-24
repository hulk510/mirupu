//
//
// Video.swift
// mirupu
//
// Created by hulk510 on 2023/10/24
// Copyright © 2023 gotoharuka . All rights reserved.
//

import Foundation

struct VideoData {
    var mainVideoURL: URL
    var choice1: Choice
    var choice2: Choice
}

struct Choice {
    var title: String
    var videoURL: URL
}
