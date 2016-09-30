//
//  URL.swift
//  Perfect-URL-Shortener
//
//  Created by Jonathan Guthrie on 2016-09-29.
//
//

import PerfectLib
import SwiftRandom

struct URLify {
	var id		: String = ""
	var url		: String = ""
	var sanity	: String = ""

	init(_ input: String) {
		let uuid = UUID()
		id = uuid.string
		self.url = input
		sanity = randomStringWithLength()
	}
	init() {}


	private func randomStringWithLength (len: Int = 8) -> String {
		let letters : String = "abcdefghijklmnopqrstuvwxyzZ0123456789"
		var randomString = ""
		for _ in 0..<len {
			let length = Int(letters.length) - 1
			let rand = Int.random(lower: 0, length)
			randomString += letters.substring(rand, length: 1)
		}
		return randomString
	}
}

