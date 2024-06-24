//
//  Application.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 24/06/24.
//

import SwiftUI
import UIKit

final class Application_utility{
    static var rootViewController: UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
            
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    
}
