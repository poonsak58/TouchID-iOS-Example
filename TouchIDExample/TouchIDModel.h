//
//  TouchIDModel.h
//  TouchIDExample
//
//  Created by macbook on 2/9/18.
//  Copyright © 2018 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <UIKit/UIKit.h>

@interface TouchIDModel : NSObject

@property (nonatomic, copy) void (^onAuthenticationWithEnterPassword)(NSString *password);
@property (nonatomic, copy) void (^onAuthenticationWithBiometricsh)(BOOL hasCompleted);
-(void)tryToLocalAuthentication:(UIViewController *)viewController;

@end
