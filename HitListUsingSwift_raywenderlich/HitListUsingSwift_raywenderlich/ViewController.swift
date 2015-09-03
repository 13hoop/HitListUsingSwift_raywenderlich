//
//  ViewController.swift
//  HitListUsingSwift_raywenderlich
//
//  Created by YongRen on 15/9/3.
//  Copyright (c) 2015年 YongRen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 姓名们...
//    var names = [String]()
    // Change “names” to “people” and [String] to [NSManagedObject]
    // 使用强大的NSManagedObject实例，来替代简单的string
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 添加联系人：借助UIAlertController
    @IBAction func addName(sender: AnyObject) {
        
        // a 创建
        var alert = UIAlertController(title: "New name", message: "Add new name", preferredStyle: UIAlertControllerStyle.Alert)
        
        //  － 保存
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (_) -> Void in
            let textField = alert.textFields![0] as! UITextField
//            self.names.append(textField.text)
            self.saveName(textField.text)
            self.tableView.reloadData()
        }
        //  － 取消
        // UIAlertActionStyle的3种style
      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
        }
//    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: nil)
        
        // b 配置
        // - 1 输入框文本的配置
        alert.addTextFieldWithConfigurationHandler { (UITextField) -> Void in
            UITextField.placeholder = "在这里输入name"
        }
        // - 2 addAction
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        // c 展现alertController
        presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
        保存输入的姓名－－－coredata
    */
    func saveName(name: String) {
        print("保存姓名，不光只是load到cell，更要对应保存到entity中...")
    }

}

// MARK: － UITableViewDataSource －
extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return names.count
        return people.count
    }
    
    // dequeues table view cells and populates them with the corresponding string in the names array
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
//        cell.textLabel?.text = names[indexPath.row]
        let person = people[indexPath.row]
        cell.textLabel?.text = person.valueForKey("name") as? String
        
        return cell
    }
}
