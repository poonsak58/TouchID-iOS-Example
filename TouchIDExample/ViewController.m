//
//  ViewController.m
//  TouchIDExample
//
//  Created by macbook on 2/8/18.
//  Copyright © 2018 macbook. All rights reserved.
//

#import "ViewController.h"
#import "NPTouchModel.h"
@interface ViewController ()

@end

@implementation ViewController{
    NPTouchModel *_touchModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _touchModel = [[NPTouchModel alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)authenticateButtonAction:(id)sender {
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {

        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Are you the device owner?" reply:^(BOOL success, NSError *error) {
            
            if (error) {

                switch (error.code) {
                    case LAErrorUserFallback:
                        [self showPasswordTextFieldInput];
                        break;
                        
                    default:
                        [self showAlertMessage:@"Error! There was a problem verifying your identity."];
                        break;
                        
                }
                
                return;
            }
            
            if (success) {
                [self showAlertMessage:@"Success! You are the device owner!"];
            } else {
                [self showAlertMessage:@"Error! You are not the device owner."];
            }
            
        }];

        
    } else {
        [self showAlertMessage:@"Error! Your device cannot authenticate using TouchID."];
    }
    
}

-(void)showAlertMessage:(NSString *)msg{
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        
        [alert addAction:noButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    });

}

-(void)showPasswordTextFieldInput{
    
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
            
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];

    });

}

@end
