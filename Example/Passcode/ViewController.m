//
//  ViewController.m
//  Passcode
//
//  Created by Hamid Farooq on 19/07/2022.
//

#import "ViewController.h"
#import <Passcode/Passcode.h>

@interface ViewController ()
@property (nonatomic, assign) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showPasscode:(id)sender {
    PasscodeViewController *controller = [[PasscodeViewController alloc] init];
    controller.titleImage = [UIImage systemImageNamed:@"multiply.circle.fill"];
    controller.titleText = @"Bok Wallet";
    controller.detailTitleText = @"Please set transition password";
    controller.isSecuredPassword = true;
    controller.blurEffactOpacity = 0.9;
    controller.gradientColors = @[[UIColor colorWithRed:119/255. green:165/255. blue:233/255. alpha:1.0], [UIColor colorWithRed:188/255. green:206/255. blue:240/255. alpha:1.0], [UIColor colorWithRed:181/255. green:207/255. blue:239/255. alpha:1.0]];
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.didEnteredPasscode = ^(NSString * _Nonnull passcode) {
        NSLog(@"%@", passcode);
        [controller dismiss];
    };
    [self presentViewController:controller animated:true completion:nil];
}

@end
