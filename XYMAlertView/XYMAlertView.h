//
//  XYMAlertView.h
//  YouXun
//
//  Created by xuym on 13-6-8.
//
//

#import <UIKit/UIKit.h>
@class XYMAlertView;

@protocol XYMAlertViewDelegate <NSObject>

- (void)alertView:(XYMAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface XYMAlertView : UIView

@property (nonatomic, retain) UIImageView *backgroundView;

// superView : like ViewController's view,NavigationController's view,or others.
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       sureBtnTitle:(NSString *)sureBtnTitle
     cancleBtnTitle:(NSString *)cancelBtnTitle
          superView:(UIView *)superView;

- (void)show;

// You can set background image whatever you want;
- (void)setXYMAlertViewBackgroudImageWithName:(NSString *)imageName;

@end
