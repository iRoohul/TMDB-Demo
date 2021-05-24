//
//  Extensions.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit

extension Dictionary {
    mutating func append(dict: [Key: Value]){
        for (k, v) in dict {
            self[k] = v
        }
    }
}

extension String {
    var formattedDate: String {
        
        let df = DateFormatter()
        //Incoming format
        df.dateFormat = "yyyy-MM-dd"
        guard let date = df.date(from: self) else {return self}
        
        //Preferred format
        df.dateFormat = "MMM d, yyyy"
        
        return df.string(from: date)
    }
    
    var completeLanguage: String? {
        Locale.current.localizedString(forLanguageCode: self)
    }
}

extension Gender {
    var placeHolderImage: UIImage {
        switch self {
        case .male:
            return #imageLiteral(resourceName: "malePlaceholder")
        case .female:
            return #imageLiteral(resourceName: "femalePlaceholder")
        case .unknown, .other:
            return #imageLiteral(resourceName: "unisexPlaceholder")
        }
    }
}

extension Int {
    var durationInHour: String? {
        if self <= 0 {return nil}
        
        let hours = self / 60
        let mins = self % 60
        
        var duration = ""
        if hours > 0 {
            duration += String(hours) + " hours"
        }
        if mins > 0 {
            duration += " " + String(mins) + " mins"
        }
        return duration.trimmingCharacters(in: .whitespaces)
    }
}
