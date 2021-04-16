//
//  Extensions.swift
//  RobustaTask
//
//  Created by Ashraf Essam on 16/04/2021.
//

import UIKit

extension UIViewController {
     func convertStringToDate(date: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        dateFormatter.locale = Locale(identifier: "en")
        //according to date format your date string
        guard let date = dateFormatter.date(from: date) else {
            fatalError()
        }
        dateFormatter.dateFormat = "dd-MM-YYYY"
        return date
    }
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.month], from: startDate, to: endDate)
        return components.month!
    }
    func NavigationTitle(title: String){
        navigationItem.title = title
    }
}
