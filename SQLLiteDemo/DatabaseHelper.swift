//
//  DatabaseHelper.swift
//  SQLLiteDemo
//
//  Created by Paresh Thakkar on 16/07/21.
//

import Foundation
import SQLite3

class DatabaseHelper {
    
    var db : OpaquePointer?
    var path : String = "myDb.sqlite"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    func createDB() -> OpaquePointer?
    {
        let filePath = try!FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        var db : OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            print("error in creating database")
            return nil
        }
        else
        {
            print(" Success to create database \(path)")
            return db
        }
    }
    func createTable()
    {
        let query = "CREATE TABLE IF NOT EXISTS Demodb(name TEXT, dateandtime TEXT);"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK
        {
            if sqlite3_step(statement) == SQLITE_DONE
            {
                print("table created Successfully")
                
            }
            else
            {
                print("table creation fail")
            }
        }
        else
        {
            print("Preparation Fail")
        }
    }
//    func insert(name:String)
//    {
//        let query = "INSERT INTO Demodb (id,name) VALUES (?, ?)"
//        var statement : OpaquePointer? = nil
//        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK
//        {
//            sqlite3_bind_int(statement, 1, 1)
//            sqlite3_bind_text(statement, 3, (name as NSString).utf8String, -1, nil)
//            if sqlite3_step(statement) == SQLITE_DONE
//            {
//                print("data inserted Successfully")
//                
//            }
//            else
//            {
//                print("data inserted fail")
//            }
//        }
//        else
//        {
//            print("Some Query Issue")
//
//        }
//    }
}
