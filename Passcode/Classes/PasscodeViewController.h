//
//  PasscodeViewController.h
//  Passcode
//
//  Created by Hamid Farooq on 19/07/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasscodeViewController : UIViewController

@property (nonatomic, copy) NSArray<UIColor *> *gradientColors;

@property (nonatomic, copy) UIImage *titleImage;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *detailTitleText;

@property (nonatomic, assign) CGFloat blurEffactOpacity;
@property (nonatomic, assign) BOOL isSecuredPassword;
@property (nonatomic, readonly) NSString *passcode;

@property (nonatomic, copy) void (^didDismissed)(void);
@property (nonatomic, copy) void (^didForgotPasscode)(void);

@property (nonatomic, copy) void (^didEnteredNumber)(NSString *code);
@property (nonatomic, copy) void (^didEnteredPasscode)(NSString *passcode);

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
