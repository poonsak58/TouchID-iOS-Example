# TouchID-iOS-Example
TouchID-iOS-Example

Easy to use

#require
LocalAuthentication.Framework

For example

-(void)authenticateExample{
    
    TouchIDModel *model = [[TouchIDModel alloc] init];
    [model tryToLocalAuthentication:self];
    
    model.onAuthenticationWithEnterPassword = ^(NSString *password){
        NSLog(@"onAuthenticationWithEnterPassword [%@]",password);
    };
    
    model.onAuthenticationWithBiometricsh = ^(BOOL hasCompleted){
        NSLog(@"onAuthenticationWithBiometricsh [%d]",hasCompleted);
    };
    
}
