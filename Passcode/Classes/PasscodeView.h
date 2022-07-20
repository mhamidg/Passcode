//
//  PasscodeView.h
//  Passcode
//
//  Created by Hamid Farooq on 19/07/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

enum CodeViewType {
    CodeViewTypeInput,
    CodeViewTypeNumber,
    CodeViewTypeDelete
};

@interface PasscodeView : UIView

@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *faceColor;
@property (nonatomic, retain) UIColor *selectedFaceColor;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIFont *font;

@property (nonatomic, assign) enum CodeViewType type;
@property (nonatomic, assign) BOOL readonly;
@property (nonatomic, assign) BOOL isSecured;

@property (nonatomic, copy) void (^didTap)(NSString *value, enum CodeViewType type);

@property (nonatomic, readonly) NSString *value;

- (void)setContentTintColor:(UIColor *)color;
- (void)setContentBackgroundColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
