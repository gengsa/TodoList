//
//  ViewController.swift
//  TodoList
//
//  Created by 王钊 on 15/8/19.
//  Copyright (c) 2015年 王钊. All rights reserved.
//

import UIKit

var todos: [Todo] = [
    Todo(id: "1", image: "child-selected", title: "1, 去游乐场", date: dateFromString("2015-06-08")!),
    Todo(id: "2", image: "shopping-cart-selected", title: "2, 购物", date: dateFromString("2015-06-13")!),
    Todo(id: "3", image: "phone-selected", title: "3, 打电话", date: dateFromString("2015-06-16")!),
    Todo(id: "4", image: "travel-selected", title: "4, 旅行", date: dateFromString("2015-06-18")!)
]
var filteredTodos: [Todo] = []

func dateFromString(string: String) ->NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.dateFromString(string)
}



class ViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.active) {
            return filteredTodos.count
        } else {
            return todos.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell
        var todo: Todo
        if (searchController.active) {
            todo = filteredTodos[indexPath.row] as Todo
        } else {
            todo = todos[indexPath.row] as Todo
        }
        
        var image = cell.viewWithTag(101) as! UIImageView
        var title = cell.viewWithTag(102) as! UILabel
        var date = cell.viewWithTag(103) as! UILabel
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        let locale = NSLocale.currentLocale()
        let dateFomate = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        let dateFomatter = NSDateFormatter()
        dateFomatter.dateFormat = dateFomate
        
        date.text = dateFomatter.stringFromDate(todo.date)
        
        return cell
    }
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (searchController.active) {
            searchController.active = false
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "todoDetailSegue" {
            var vc = segue.destinationViewController as! TodoDetailViewController
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
        }
    }
    

    // Unwind Segue
    @IBAction func close(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

    
    
    // editting
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    //move cell
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
        
    }
    
    // delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            todos.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    
    // from UISearchResultsUpdating
    // update search result
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filteredTodos = todos.filter({(todo: Todo) -> Bool
            in
            return searchText == "" || todo.title.rangeOfString(searchText) != nil
        })
        self.tableView.reloadData()
    }
}

