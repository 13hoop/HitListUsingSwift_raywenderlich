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
    
//    var names = [String]()
    // Change “names” to “people” and [String] to [NSManagedObject]
    // 使用强大的NSManagedObject实例，来替代简单的string
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(animated: Bool) {
        loadName("Person")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // 添加联系人：借助UIAlertController
    @IBAction func addName(sender: AnyObject) {
        
        // a 创建
        var alert = UIAlertController(title: "New name", message: "Add new name", preferredStyle: UIAlertControllerStyle.Alert)
        
        //  － 保存
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (_) -> Void in
            let textField = alert.textFields![0] as! UITextField
//          self.names.append(textField.text)
            // 保存核心方法
            self.saveName(textField.text)
            self.tableView.reloadData()
        }
        //  － 取消
      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
        }
        
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
        保存/data persistence－－－coredata
    */
    func saveName(name: String) {
        print("保存姓名，不光只是load到cell，更要对应保存到entity中...")
        
        // 1 获取对象托管上下文－－xcode自动在AppDelegate中创建
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // 2 创建被托管的对象，并添加到上下文中－－与创建的database文件对映
        // An entity description is the piece that links the entity definition from your data model with an instance of NSManagedObject at runtime.
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext!)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext!)

        // 3 使用KVC向属性（attribute）赋值
        person.setValue(name, forKey: "name")
        
        // 4 错误处理
        var error: NSError?
        if !managedContext!.save(&error) {
            print("保存失败！\(error),\(error?.userInfo)")
        }
        
        // 5 也要添加到‘联系人’数组－－内存中
        people.append(person)
    }
    
    /*
        获取/Fetch data－－－coredata
    */
    func loadName(entityName: String) {
        
        // 1 获取context
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // 2 创建获取请求，以实体名称搜索
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        // 3 错误处理
        var error: NSError?
        
        let fetchResults = managedContext?.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        // 正确获取结果，则读取数据到Person，如果错误则输出错误
        if let results = fetchResults {
            people = results
        } else {
            print("读取数据错误!\(error),\(error!.userInfo)")
        }
    }

}

// MARK: － UITableViewDataSource －
extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return names.count
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
//        cell.textLabel?.text = names[indexPath.row]
        let person = people[indexPath.row]
        cell.textLabel?.text = person.valueForKey("name") as? String
        
        return cell
    }
}
