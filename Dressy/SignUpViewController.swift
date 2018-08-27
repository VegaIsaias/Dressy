//
//  SignUpViewController.swift
//  Dressy
//
//  Created by Isaias Perez Vega on 8/9/15.
//  Copyright (c) 2015 BitEngine. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: ViewController
{
    
    
    override func displayAlert(title: String, message: String) //Generic alert function, same function from sign in file
    {
        
        var alertError = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertError.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertError, animated: true, completion: nil)
    }
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signUp(sender: AnyObject)
    {
        if username.text == "" || password.text == ""  //condition shows an error if the user leaves the fields blank and submits a request. 
        {
            
            displayAlert("Error", message: "Please enter a username and password")
            
        } else {
                    //shows and activates activity indicator and stops application functionality
                    activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                    activityIndicator.center = self.view.center
                    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                    view.addSubview(activityIndicator)
                    activityIndicator.startAnimating()
                    activityIndicator.hidesWhenStopped = true
                    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
                    //Parse signup protocol
                    var user = PFUser()
            
                    user.username = username.text
                    user.password = password.text
            
                    var errorMassage = "Please try again later"
            
                    user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                        
                        activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if error == nil //checks for error and displays it in an alert if present else continues with protocol
                        {
                          println("Logged in!")  //Signup Success
                        } else {
                            if let errorString = error!.userInfo?["error"] as? String
                            {
                                errorMassage = errorString
                            }
                            
                            self.displayAlert("Sign Up Failed!", message: errorMassage)
                               }
                        
                        
                    })
            
               }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
