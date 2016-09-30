//
//  Handlers.swift
//  Perfect-URL-Shortener
//
//  Created by Jonathan Guthrie on 2016-09-29.
//
//

import PerfectLib
import SQLite
import PerfectHTTP
import PerfectMustache
import SwiftString

/*
These are the main Mustache handlers.
They are called as the handlers from the routes in main.swift
*/


struct IndexHandler: MustachePageHandler { // all template handlers must inherit from PageHandler
	// This is the function which all handlers must impliment.
	// It is called by the system to allow the handler to return the set of values which will be used when populating the template.
	// - parameter context: The MustacheWebEvaluationContext which provides access to the HTTPRequest containing all the information pertaining to the request
	// - parameter collector: The MustacheEvaluationOutputCollector which can be used to adjust the template output. For example a `defaultEncodingFunc` could be installed to change how outgoing values are encoded.

	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {

		var values = MustacheEvaluationContext.MapType()
		let dbHandler = DB()
		let data = dbHandler.getList()
		var ary = [Any]()

		for i in 0..<data.count {
			var thisURL = [String:String]()
			thisURL["id"] = data[i].id
			thisURL["url"] = data[i].url
			thisURL["sanity"] = "http://localhost:8181/to/\(data[i].sanity)"
			ary.append(thisURL)
		}
		values["urls"] = ary
		contxt.extendValues(with: values)

		do {
			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}




struct URLSHandler: MustachePageHandler { // all template handlers must inherit from PageHandler
	// This is the function which all handlers must impliment.
	// It is called by the system to allow the handler to return the set of values which will be used when populating the template.
	// - parameter context: The MustacheWebEvaluationContext which provides access to the HTTPRequest containing all the information pertaining to the request
	// - parameter collector: The MustacheEvaluationOutputCollector which can be used to adjust the template output. For example a `defaultEncodingFunc` could be installed to change how outgoing values are encoded.

	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		var values = MustacheEvaluationContext.MapType()
		let request = contxt.webRequest

		let urlinput = request.param(name: "url", defaultValue: "http://")!
		let dbHandler = DB()

		if urlinput.characters.count > 0 && urlinput != "http://" {
			let newURL = URLify(urlinput)
			print("New URL: \(newURL.id), \(newURL.url), \(newURL.sanity)")
			let _ = dbHandler.saveURL(newURL)
		}

		let data = dbHandler.getList()
		var ary = [Any]()

		for i in 0..<data.count {
			var thisURL = [String:String]()
			thisURL["id"] = data[i].id
			thisURL["url"] = data[i].url
			thisURL["sanity"] = "http://localhost:8181/to/\(data[i].sanity)"
			ary.append(thisURL)
		}
		values["urls"] = ary
		contxt.extendValues(with: values)

		contxt.extendValues(with: values)
		do {
			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}



