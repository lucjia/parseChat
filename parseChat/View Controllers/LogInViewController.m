//
//  LogInViewController.m
//  parseChat
//
//  Created by lucjia on 7/10/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "LogInViewController.h"
#import "Parse/Parse.h"

@interface LogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didPressSignUp:(id)sender {
    [self registerUser];
}

- (IBAction)didPressLogIn:(id)sender {
    [self loginUser];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            
            if ([self.usernameField.text isEqual:@""]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Username"
                                                                               message:@"Please enter a username."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                // create a cancel action
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                                         // handle cancel response here. Doing nothing will dismiss the view.
                                                                     }];
                // add the cancel action to the alertController
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            } else if ([self.passwordField.text isEqual:@""]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Password"
                                                                               message:@"Please enter a password."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                // create a cancel action
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                                         // handle cancel response here. Doing nothing will dismiss the view.
                                                                     }];
                // add the cancel action to the alertController
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                                               message:@"There was an error with signing up or logging in."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                // create a cancel action
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                                         // handle cancel response here. Doing nothing will dismiss the view.
                                                                     }];
                // add the cancel action to the alertController
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
