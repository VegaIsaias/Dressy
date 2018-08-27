//
//  LogInViewController.swift
//  Dressy
//
//  Created by Isaias Perez Vega on 7/29/15.
//  Copyright (c) 2015 BitEngine. All rights reserved.
//

import UIKit
import Parse

var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()  //Initiate a variable for the activity indcator function

class ViewController: UIViewController {
    
    
    //Function can be called in the program to display various alerts based on the code from parse.
    func displayAlert (title: String, message: String)
    {
        var alertError = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertError.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertError, animated: true, completion: nil)
    }
    
    @IBOutlet weak var logUsername: UITextField!
    
    @IBOutlet weak var logPassword: UITextField!
    
    @IBAction func logIn(sender: AnyObject)
    {
         var errorMassage = "Please try again later"
        
        //shows and activates activity indicator and stops application functionality
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        PFUser.logInWithUsernameInBackground(logUsername.text, password: logPassword.text) { (user, error) -> Void in
            
            activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if user != nil
            {
                //Log In successful!
            } else
                    {
                        if let errorString = error!.userInfo?["error"] as? String
                        {
                            errorMassage = errorString
                        }
                
                        self.displayAlert("Log In Failed!", message: errorMassage) //Displays an error massege if  login fails
                    }
            
            
        }
    
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

