//
//  Dater.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 29/06/24.
//

import UIKit

class Dater: DateFormatter {
    
    static var shared = Dater()
    
    private override init() {
        super.init()
        self.locale = NSLocale(localeIdentifier: "en_US") as Locale?
    }
    
    func date(from string: String, format: String) -> Date? {
        self.dateFormat = format
        return date(from: string)
    }
    
    func string(from date: Date, format: String) -> String? {
        self.dateFormat = format
        return string(from: date)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
