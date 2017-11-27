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

    let animations :[Animation] = [Star(), Torus(), Seed(), StrokeAnimation(), Spinner()]
    
    @IBOutlet var scopeView :ScopeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scopeView.captureTarget = StrokeAnimation()
    }

    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return nil
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return animations[index]
        }
        return ""
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    
    func outlineView(_ outlineView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return animations[row]
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: self) as! NSTableCellView
        if let animation = item as? Animation { cell.textField?.stringValue = animation.name }
        return cell
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return animations.count
        }
        return 0
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        let outlineView = notification.object as! NSOutlineView
        scopeView.captureTarget = animations[outlineView.selectedRow]
    }

    @IBAction func saveDocument(_ sender: AnyObject?) {
        captureGifFromWindow(scopeView.window!, captureTarget: scopeView.captureTarget)
    }
    
    @IBAction func saveSequence(_ sender: AnyObject?) {
        captureSequenceFromWindow(scopeView.window!, captureTarget: scopeView.captureTarget)
    }
}

