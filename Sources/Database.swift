//
//  Database.swift
//  Perfect-URL-Shortener
//
//  Created by Jonathan Guthrie on 2016-09-28.
//
//

import PerfectLib
import SQLite
import PerfectHTTP
import PerfectMustache
import SwiftString

// bandles database interactions
class DB {
	// The path to the SQLite database file
	let dbPath = "./url-database"

	// Create the database, and table.
	func create() {
		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}

			try sqlite.execute(statement: "CREATE TABLE IF NOT EXISTS urls (id TEXT PRIMARY KEY NOT NULL, url TEXT NOT NULL, sanity TEXT NOT NULL)")

		} catch {
			//Handle Errors
			print(error)
		}
	}



	// The function that retrieves the list of blog posts
	func getList() -> [URLify] {
		var data = [URLify]()

		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}

			let demoStatement = "SELECT id,url,sanity FROM urls"

			try sqlite.forEachRow(statement: demoStatement, handleRow: {(statement: SQLiteStmt, i:Int) -> () in
				var this = URLify()
				this.id = String(statement.columnText(position: 0))
				this.url = String(statement.columnText(position: 1))
				this.sanity = String(statement.columnText(position: 2))
				data.append(this)
			})

		} catch {
			//Handle Errors
			print(error)
		}
		return data

	}

	// Getting the url
	func getURL(_ opt: String) -> String {
		var url = ""

		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}
			
			try sqlite.forEachRow(statement: "SELECT url FROM urls WHERE sanity = ? LIMIT 1", doBindings: {

				(statement: SQLiteStmt) -> () in
				try statement.bind(position: 1, opt)

				}, handleRow: {(statement: SQLiteStmt, i:Int) -> () in
					url = String(statement.columnText(position: 0))
			})

		} catch {
			//Handle Errors
			print(error)
		}
		return url
	}


	// Saving the url
	func saveURL(_ this: URLify) -> URLify {
		var data = URLify()
		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}

			let demoStatement = "INSERT INTO urls (id,url,sanity) VALUES(:1,:2,:3)"

			try sqlite.forEachRow(statement: demoStatement, doBindings: {

				(statement: SQLiteStmt) -> () in

				try statement.bind(position: 1, this.id)
				try statement.bind(position: 2, this.url)
				try statement.bind(position: 3, this.sanity)

				}, handleRow: {(statement: SQLiteStmt, i:Int) -> () in
					data.id = String(statement.columnText(position: 0))
					data.url = String(statement.columnText(position: 1))
					data.sanity = String(statement.columnText(position: 2))
			})

		} catch {
			//Handle Errors
			print(error)
		}
		return data
	}
}

