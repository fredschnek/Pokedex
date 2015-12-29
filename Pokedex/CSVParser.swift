//
//  CSVParser.swift
//  Pokedex
//
//  Created by Frederico Schnekenberg on 28/12/15.
//  Copyright © 2015 Frederico Schnekenberg. All rights reserved.
//

import Foundation

public class CSVParser
{
    // MARK: --- Properties ---
    public var rows:    [[String: String]] = []
    public var headers: [String] = []

    public var columns = [String: [String]]()
    var delimiter = NSCharacterSet(charactersInString: ",")
    
    // MARK: --- Initializers ---
    public init(content: String?, delimiter: NSCharacterSet, encoding: UInt) throws
    {
        if let csvStringToParse = content {
            self.delimiter = delimiter
            
            let newline = NSCharacterSet.newlineCharacterSet()
            var lines: [String] = []
            csvStringToParse.stringByTrimmingCharactersInSet(newline).enumerateLines( { (line, stop) -> () in lines.append(line) } )
            
            self.headers = self.parseHeaders(fromLines: lines)
            self.rows = self.parseRows(fromLines: lines)
            self.columns = self.parseColumns(fromLines: lines)
        }
    }
    
    public convenience init(contentsOfUrl url: String) throws
    {
        let comma = NSCharacterSet(charactersInString: ",")
        let csvString: String?
        
        do {
            csvString = try String(contentsOfFile: url, encoding: NSUTF8StringEncoding)
        } catch _ {
            csvString = nil
        }
        
        try self.init(content: csvString, delimiter: comma, encoding: NSUTF8StringEncoding)
    }
    
    // MARK: --- Utility Functions ---
    func parseHeaders(fromLines lines: [String]) -> [String]
    {
        return lines[0].componentsSeparatedByCharactersInSet(self.delimiter)
    }
    
    func parseRows(fromLines lines: [String]) -> [[String: String]]
    {
        var rows: [[String: String]] = []
        
        for (lineNumber, line) in lines.enumerate() {
            if lineNumber == 0 {
                continue
            }
            
            var row = [String: String]()
            let values = line.componentsSeparatedByCharactersInSet(self.delimiter)
            for (index, header) in self.headers.enumerate() {
                if index < values.count {
                    row[header] = values[index]
                } else {
                    row[header] = ""
                }
            }
            rows.append(row)
        }
        
        return rows
    }
    
    func parseColumns(fromLines lines: [String]) -> [String: [String]]
    {
        var columns = [String: [String]]()
        
        for header in self.headers {
            let column = self.rows.map {
                row in row[header] != nil ? row[header]! : ""
            }
            columns[header] = column
        }
        
        return columns
    }
}