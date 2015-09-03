//
//  ViewController.swift
//  HitListUsingSwift_raywenderlich
//
//  Created by YongRen on 15/9/3.
//  Copyright (c) 2015年 YongRen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 姓名们...
    var names = [String]()
    
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
            self.names.append(textField.text)
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

}

// MARK: － UITableViewDataSource －
extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    // dequeues table view cells and populates them with the corresponding string in the names array
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
}
