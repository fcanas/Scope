//
//  ViewController.swift
//  Scope
//
//  Created by Fabian Canas on 11/29/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class ViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {

    let animations :[Animation] = [Star(), Torus(), Seed(), StrokeAnimation()]
    
    @IBOutlet var scopeView :ScopeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scopeView.captureTarget = StrokeAnimation()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        return nil
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if item == nil {
            return animations[index]
        }
        return ""
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return false
    }
    
    func outlineView(outlineView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return animations[row]
    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        let cell = outlineView.makeViewWithIdentifier("DataCell", owner: self) as! NSTableCellView
        (item as? Animation).map { cell.textField?.stringValue = $0.name }
        return cell
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if item == nil {
            return animations.count
        }
        return 0
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification) {
        let outlineView = notification.object as! NSOutlineView
        scopeView.captureTarget = animations[outlineView.selectedRow]
    }

    @IBAction func saveDocument(sender: AnyObject?) {
        captureGifFromWindow(scopeView.window!, captureTarget: scopeView.captureTarget)
    }
}

