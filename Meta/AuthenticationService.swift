//
//  AuthenticationService.swift
//  Meta
//
//  Created by Anasuya Dev on 08/02/22.
//

import Foundation
import LocalAuthentication

class AuthenticationService
{
    func authenticateUsingTouchhId(completion: @escaping (Bool, Error?) -> Void)
    {
       let context = LAContext()
        var error: NSError?
         
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error )
        {
           let reason = "TouchId authentication is required"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { ( success, error) in
                DispatchQueue.main.async{
                completion(success,error)
            }
            }
            
        }
    }
}
