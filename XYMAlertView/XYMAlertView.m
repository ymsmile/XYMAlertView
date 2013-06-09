//
//  XYMAlertView.m
//  YouXun
//
//  Created by xuym on 13-6-8.
//
//

#import "XYMAlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface XYMAlertView ()
{
    UIView                          *m_superView;
    UIView                          *m_alertShowView;
    id<XYMAlertViewDelegate>        m_delegate;
}
@end

@implementation XYMAlertView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       sureBtnTitle:(NSString *)sureBtnTitle
     cancleBtnTitle:(NSString *)cancelBtnTitle
          superView:(UIView *)superView
{
    self = [super initWithFrame:CGRectZero];
    
    // set delegate and superview
    m_delegate  = delegate;
    m_superView = superView;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    // set alert view frame
    [self setFrame:CGRectMake(0, 0, 270, 160)];
    
    // set title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.textColor = [UIColor colorWithRed:76/255.0 green:80/255.0 blue:83/255.0 alpha:1];
	titleLabel.font = [UIFont boldSystemFontOfSize:19];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = title;
    [self addSubview:titleLabel];
	[titleLabel release];
    
    // set message label
    UIFont *messageLabelFont = [UIFont systemFontOfSize:17];
    CGSize messagesize = [message sizeWithFont:messageLabelFont
                             constrainedToSize:CGSizeMake(self.frame.size.width-10*2, 120)
                                 lineBreakMode:UILineBreakModeWordWrap];
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.frame.origin.y+titleLabel.frame.size.height, self.frame.size.width-10*2, messagesize.height)];
	messageLabel.backgroundColor = [UIColor clearColor];
	messageLabel.textColor =[UIColor colorWithRed:76/255.0 green:80/255.0 blue:83/255.0 alpha:1];
	messageLabel.font = [UIFont systemFontOfSize:17];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = UITextAlignmentCenter;
    messageLabel.lineBreakMode = UILineBreakModeWordWrap;
	messageLabel.text = message;
    [self addSubview:messageLabel];
	[messageLabel release];
    
    // set sure button
    UIButton *sureBtn;
    if (sureBtnTitle != nil)
    {
        if (cancelBtnTitle != nil)
        {
            sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [sureBtn setBackgroundColor:[UIColor blueColor]];
            [sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [sureBtn setTitle:sureBtnTitle forState:UIControlStateNormal];
            [sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_alertbutton"] forState:UIControlStateNormal];
            sureBtn.frame=CGRectMake(15, messageLabel.frame.origin.y+messagesize.height+10, 114, 51);
            [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            sureBtn.tag = 100;
            [self addSubview:sureBtn];
        } else {
            sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [sureBtn setTitle:sureBtnTitle forState:UIControlStateNormal];
            UIImage *img = [UIImage imageNamed:@"btn_alertbutton"];
            img = [img stretchableImageWithLeftCapWidth:6 topCapHeight:0];
            [sureBtn setBackgroundImage:img forState:UIControlStateNormal];
            sureBtn.frame=CGRectMake(30, messageLabel.frame.origin.y+messagesize.height+10, self.frame.size.width - 30*2, 51);
            [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            sureBtn.tag = 100;
            [self addSubview:sureBtn];
        }
	}
    
    // set cancle button
    UIButton *cancleBtn;
    if (cancelBtnTitle != nil)
    {
        cancleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
		[cancleBtn setTitle:cancelBtnTitle forState:UIControlStateNormal];
		[cancleBtn setBackgroundImage:[UIImage imageNamed:@"btn_alertbutton"] forState:UIControlStateNormal];
		[cancleBtn setFrame:CGRectMake(15*2+114, messageLabel.frame.origin.y+messagesize.height+10, 114, 51)];
		[cancleBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
		cancleBtn.tag = 101;
		[self addSubview:cancleBtn];
    }
    // calculate the new frame of alert view
    [self setFrame:CGRectMake(0, 0, 270, messageLabel.frame.origin.y+messagesize.height+10+51+15)];
    
    // set background view
    _backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _backgroundView.image = [UIImage imageNamed:@"bg_alertview"];
	[self addSubview:_backgroundView];
	[self sendSubviewToBack:_backgroundView];
    
    return self;
}

- (void)setXYMAlertViewBackgroudImageWithName:(NSString *)imageName
{
    _backgroundView.image = [UIImage imageNamed:imageName];
}

- (void)buttonClick:(UIButton *)button
{
//    CABasicAnimation *boundSmallAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//	boundSmallAnimation.removedOnCompletion = YES;
//	boundSmallAnimation.duration = 0.1;
//	boundSmallAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,1.0,1)];
//	boundSmallAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3,1.3,1)];
//	[self.layer addAnimation:boundSmallAnimation forKey:@"scaleSmall"];
    
    [self beginViewAnimationWithId:@"bgdisappear" alpha:0.0];
    
    if (m_delegate)
        [m_delegate alertView:self clickedButtonAtIndex:button.tag];
}

- (void)show
{
    m_alertShowView = [[UIView alloc]initWithFrame:m_superView.bounds];
    m_alertShowView.userInteractionEnabled = YES;
	m_alertShowView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    
	[m_superView addSubview:m_alertShowView];
    [self setCenter:m_alertShowView.center];
	[m_superView addSubview:self];
    
	CABasicAnimation *boundBigAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	boundBigAnimation.removedOnCompletion = YES;
	boundBigAnimation.duration = 0.2;
	boundBigAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2,0.2,1)];
	boundBigAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1,1.1,1)];
	[self.layer addAnimation:boundBigAnimation forKey:@"scaleBig"];
    
    [self beginViewAnimationWithId:@"bgappear" alpha:1.0];
}

- (void)beginViewAnimationWithId:(NSString *)animationId alpha:(float)alpha
{
    [UIView beginAnimations:animationId context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	self.alpha = alpha;
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationId finished:(NSNumber *)finished context:(void *)context
{
	if ([animationId isEqualToString:@"bgappear"])
	{
        
	} else if([animationId isEqualToString:@"bgdisappear"])
	{
		[[self superview] setAlpha:1.0];
		[m_alertShowView removeFromSuperview];
		[m_alertShowView release];
		[self removeFromSuperview];
	}
}

- (void)dealloc
{
    [super dealloc];
	self.backgroundView = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
