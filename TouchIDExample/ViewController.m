//
//  ViewController.m
//  TouchIDExample
//
//  Created by macbook on 2/8/18.
//  Copyright © 2018 macbook. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDModel.h"

@interface ViewController ()
@end

@implementation ViewController{
    TouchIDModel *_model;

}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)authenticateButtonAction:(id)sender {
    
    TouchIDModel *model = [[TouchIDModel alloc] init];
    [model tryToLocalAuthentication:self];
    
    model.onAuthenticationWithEnterPassword = ^(NSString *password){
        NSLog(@"onAuthenticationWithEnterPassword [%@]",password);
    };
    
    model.onAuthenticationWithBiometricsh = ^(BOOL hasCompleted){
        NSLog(@"onAuthenticationWithBiometricsh [%d]",hasCompleted);
    };

    
}

@end
