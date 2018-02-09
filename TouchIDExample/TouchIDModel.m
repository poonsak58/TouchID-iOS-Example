//
//  TouchIDModel.m
//  TouchIDExample
//
//  Created by macbook on 2/9/18.
//  Copyright © 2018 macbook. All rights reserved.
//

#import "TouchIDModel.h"
#import <UIKit/UIKit.h>
@implementation TouchIDModel


-(void)tryToLocalAuthentication:(UIViewController *)viewController{
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Are you the device owner?" reply:^(BOOL success, NSError *error) {
            
            if (error) {
                
                switch (error.code) {
                    case LAErrorUserFallback:
                        [self showPasswordTextFieldInput:viewController];
                        break;
                        
                    default:
                        [self showAlertMessage:@"Error! There was a problem verifying your identity." viewController:viewController];
                        if (self.onAuthenticationWithBiometricsh) {
                            self.onAuthenticationWithBiometricsh(false);
                        }
                        break;
                        
                }
                
                return;
            }
            
            
            if (success) {
                [self showAlertMessage:@"Success! You are the device owner!" viewController:viewController];
            } else {
                [self showAlertMessage:@"Error! You are not the device owner." viewController:viewController];
            }

            if (self.onAuthenticationWithBiometricsh) {
                self.onAuthenticationWithBiometricsh(success);
            }
            
            
        }];
        
        
    } else {
        
        [self showAlertMessage:@"Error! Your device cannot authenticate using TouchID." viewController:viewController];
        if (self.onAuthenticationWithBiometricsh) {
            self.onAuthenticationWithBiometricsh(false);
        }
        
    }
    
}

-(void)showAlertMessage:(NSString *)msg viewController:(UIViewController *)viewController{
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        
        [alert addAction:noButton];
        [viewController presentViewController:alert animated:YES completion:nil];
        
    });
    
}

-(void)showPasswordTextFieldInput:(UIViewController *)viewController{
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Login"
                                                                                  message:@"Password"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"password";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.secureTextEntry = YES;
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            if ([alertController.textFields count] > 0) {
                
                NSString *password = alertController.textFields[0].text;
                if (password.length > 0) {
                    
                    if (self.onAuthenticationWithEnterPassword) {
                        self.onAuthenticationWithEnterPassword(password);
                        return;
                    }

                }

            }
            
            [self showAlertMessage:@"Error! You are not the device owner." viewController:viewController];
            if (self.onAuthenticationWithBiometricsh) {
                self.onAuthenticationWithBiometricsh(false);
            }

            

        }]];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
    });
    
}


@end
