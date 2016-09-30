//
//  Package.swift
//  Perfect Cookie Demo
//
//  Created by Jonathan Guthrie on 2016-09-28.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PackageDescription

// Note that the following Swift Package Manager dependancy inclusion will also import other required modules.
let package = Package(
	name: "PerfectURLShortener",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-SQLite.git", majorVersion: 2, minor: 0),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2, minor: 0),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2, minor: 0),
		.Package(url: "https://github.com/iamjono/SwiftString.git",majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/iamjono/SwiftRandom.git",majorVersion: 0, minor: 2)
	]
)
