//
//  ControllerProvider.swift
//  RobustaTask
//
//  Created by Ashraf Essam on 16/04/2021.
//

import UIKit

enum StoryboardType: String {
    case MainStoryboard = "Main"
}

class ControllerProvider {
    class func viewContoller<vc: UIViewController>(className: vc.Type, storyboard: StoryboardType,presentationStyle:UIModalPresentationStyle) -> vc{
        let story = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let identifier = String(describing: className.self)
        let vc = story.instantiateViewController(withIdentifier: identifier) as! vc
        vc.modalPresentationStyle = presentationStyle
        return vc
    }
}
