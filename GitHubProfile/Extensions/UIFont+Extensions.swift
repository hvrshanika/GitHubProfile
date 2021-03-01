//
//  UIFont+Extensions.swift
//  GitHubProfile
//
//  Created by Shanika Vithanage on 2/28/21.
//

import Foundation
import UIKit

extension UIFont {
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "SourceSansPro-Regular", size: size)!
    }
    
    class func appSemiBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "SourceSansPro-SemiBold", size: size)!
    }
    
    class func appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "SourceSansPro-Bold", size: size)!
    }
}
