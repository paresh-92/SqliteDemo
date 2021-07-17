//
//  GarmainDetailVC.swift
//  SQLLiteDemo
//
//  Created by Paresh Thakkar on 16/07/21.
//

import UIKit
import SQLite3


class GarmainDetailVC: UIViewController {

    
    @IBOutlet weak var txtGarmentName: UITextField!
    
    var db = DatabaseHelper()
    var date = String()
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        isertDataInDataBase()
    }
    
}
extension GarmainDetailVC
{
    func isertDataInDataBase()
    {
        let insertStatementString = "INSERT INTO Demodb (name, dateandtime) VALUES (?, ?);"
        var inserStatementQuery : OpaquePointer?
        if sqlite3_prepare_v2(db.db, insertStatementString, -1, &inserStatementQuery, nil) == SQLITE_OK
        {
            
            let dateFormatter = DateFormatter()
            let datePicker = UIDatePicker()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            date = dateFormatter.string(for: datePicker.date)!
            
            sqlite3_bind_text(inserStatementQuery, 1, txtGarmentName.text ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(inserStatementQuery, 2, date, -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(inserStatementQuery) == SQLITE_DONE
            {
                txtGarmentName.text = ""
                txtGarmentName.resignFirstResponder()
                print("data inserted Successfully")
                self.navigationController?.popViewController(animated: true)
            }
            else
            {
                print("Error")
            }
            sqlite3_finalize(inserStatementQuery)
        }
        
        
        
    }
}
