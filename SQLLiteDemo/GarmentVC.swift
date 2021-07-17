//
//  GarmentVC.swift
//  SQLLiteDemo
//
//  Created by Paresh Thakkar on 16/07/21.
//

import UIKit
import SQLite3
class GarmentVC: UIViewController {

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var btnAlphabate: UIButton!
    @IBOutlet weak var btncreationDate: UIButton!
    var db = DatabaseHelper()
    var dict : [String:Any] = [:]
    var showArray : [[String:Any]] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblList.tableFooterView = UIView(frame: .zero)

    }
    override func viewWillAppear(_ animated: Bool) {
        readData()
    }
    @IBAction func btnAlphabaticClicked(_ sender: UIButton) {
        self.btncreationDate.backgroundColor = .clear
        self.btnAlphabate.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        setByAlphabatecOrder()
        tblList.reloadData()
    }
    @IBAction func btnCreationTimeClicked(_ sender: UIButton) {
        self.btncreationDate.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.btnAlphabate.backgroundColor = .clear
        setByDateOrder()
        tblList.reloadData()

    }
    @IBAction func btnAddClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "GarmainDetailVC") as! GarmainDetailVC
        self.btncreationDate.backgroundColor = .clear
        self.btnAlphabate.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func readData()
    {
        let selectStatementString = "SELECT name, dateandtime FROM Demodb"
        var selectStatementQuery : OpaquePointer?
        showArray.removeAll()
        if sqlite3_prepare_v2(db.db, selectStatementString, -1, &selectStatementQuery, nil) == SQLITE_OK
        {
            while sqlite3_step(selectStatementQuery)==SQLITE_ROW {
                dict["Garment Name"] = String(cString: sqlite3_column_text(selectStatementQuery, 0))
                    
                 dict["Date and Time"] = String(cString: sqlite3_column_text(selectStatementQuery, 1))
                showArray.append(dict)
            }
            sqlite3_finalize(selectStatementQuery)
            setByAlphabatecOrder()
            tblList.reloadData()
        }
    }
    func setByAlphabatecOrder()
    {
        self.showArray.sort{
            (($0 as Dictionary<String, AnyObject>)["Garment Name"] as? String ?? "") < (($1 as Dictionary<String, AnyObject>)["Garment Name"] as? String ?? "")
        }
    }
    func setByDateOrder()
    {
        self.showArray.sort{
            (($0 as Dictionary<String, AnyObject>)["Date and Time"] as? String ?? "") < (($1 as Dictionary<String, AnyObject>)["Date and Time"] as? String ?? "")
        }
    }
}
extension GarmentVC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblList.dequeueReusableCell(withIdentifier: "GarmentCell", for: indexPath) as! GarmentCell
        let dict = showArray[indexPath.row]
        cell.lblGarmentName.text = dict["Garment Name"] as? String
        return cell
    }
    
    
}
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

