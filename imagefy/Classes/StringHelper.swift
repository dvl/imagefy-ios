//
//  StringHelper.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

extension String {
    func beginsWith(str: String) -> Bool {
        if let range = self.rangeOfString(str) {
            return range.startIndex == self.startIndex
        }
        return false
    }
    
    func formatInt() -> String {
        let fmt = NSNumberFormatter()
        fmt.numberStyle = .DecimalStyle
        fmt.locale = NSLocale.currentLocale()
        
        if let number = Int(self) {
            if let _str = fmt.stringFromNumber(number) {
                return _str
            }
        }
        
        return self
    }
}
