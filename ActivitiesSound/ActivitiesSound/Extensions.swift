//
//  Extensions.swift
//  Spotify
//
//  Created by  on 19.03.2021.
//

import Foundation
import UIKit

extension UIView{
    var widht: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + widht
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
    
}


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String {
    static func formattetDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else { return string }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
 }

extension Notification.Name {
    static let albumSavedNotification = Notification.Name("albumSavedNotification")
    
}
