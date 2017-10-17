//
//  NodesCollectionView.swift
//  Sweetcorn
//
//  Created by Simon Gladman on 14/03/2016.
//  Copyright © 2016 Simon Gladman. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>

import Cocoa


class NodeTypesList: NSScrollView
{
    @objc let tableView = TableViewNoDragImage()
    
    let model: SweetcornModel
    
    required init(model: SweetcornModel)
    {
        self.model = model
        
        super.init(frame: CGRect.zero)

        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: ""))
        tableView.addTableColumn(column)

        tableView.headerView = nil
        tableView.backgroundColor = NSColor.darkGray
        
        tableView.dataSource = self
        tableView.delegate = self
        
        documentView = tableView
        
        horizontalScroller = nil
        
        shadow = NSShadow()
        shadow?.shadowColor = NSColor.black
        shadow?.shadowBlurRadius = 5
        shadow?.shadowOffset = NSSize(width: 0, height: 0)
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class TableViewNoDragImage: NSTableView
{
    override func dragImageForRows(with dragRows: IndexSet, tableColumns: [NSTableColumn], event dragEvent: NSEvent, offset dragImageOffset: NSPointPointer) -> NSImage {
        return NSImage()
    }
}

extension NodeTypesList: NSTableViewDataSource, NSTableViewDelegate
{
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool
    {
        pboard.addTypes([NSPasteboard.PasteboardType(rawValue: "DraggingSweetcornNodeType")], owner: self)
        
        model.draggingNodeTypeName = model.nodeTypes[rowIndexes.first!].name
        
        return true
    }
    
    func tableView(_ tableView: NSTableView, shouldEdit tableColumn: NSTableColumn?, row: Int) -> Bool
    {
        return false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return model.nodeTypes.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
    {
        return model.nodeTypes[row].name
    }
}
