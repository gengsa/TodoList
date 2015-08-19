//
//  TodoDetailController.swift
//  TodoList
//
//  Created by 王钊 on 15/8/19.
//  Copyright (c) 2015年 王钊. All rights reserved.
//
import UIKit

class TodoDetailViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var childButton: UIButton!

    @IBOutlet var phoneButton: UIButton!
    @IBOutlet var shoppingCartButton: UIButton!
    @IBOutlet var travelButton: UIButton!
    
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var todo: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        todoItem.delegate = self
        if (todo == nil) {
            childButton.selected = true;
            navigationController?.title = "新建 todo"
        } else {
            if todo?.image == "child-selected"{
                childButton.selected = true
            }
            else if todo?.image == "phone-selected"{
                phoneButton.selected = true
            }
            else if todo?.image == "shopping-cart-selected"{
                shoppingCartButton.selected = true
            }
            else if todo?.image == "travel-selected"{
                travelButton.selected = true
            }
            todoItem.text = todo?.title
            todoDate.setDate((todo?.date)!, animated: false)
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons() {
        childButton.selected = false
        phoneButton.selected = false
        
        shoppingCartButton.selected = false
        travelButton.selected = false
    }
    
    
    @IBAction func imageTapped(sender: UIButton) {
        resetButtons()
        sender.selected = true
    }
    
    
    
    // from UITextFieldDelegate
    // hide keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 点击键盘的父容器就会激活, hide keyboard
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        var image = ""
        if (childButton.selected) {
            image = "child-selected"
        } else if (phoneButton.selected) {
            image = "phone-selected"
        } else if (shoppingCartButton.selected) {
            image = "shopping-cart-selected"
        } else if (travelButton.selected) {
            image = "travel-selected"
        }
        if (todo == nil) {
            // New todo
            let uuid = NSUUID().UUIDString // Spport Xcode 6.1
            self.todo = Todo(id: uuid, image: image, title: todoItem.text, date: todoDate.date)
            todos.append(todo!)
        } else {
            todo?.image = image
            todo?.title = todoItem.text
            todo?.date = todoDate.date

        }
        
        

        
    }
    
}
