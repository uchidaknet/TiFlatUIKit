//
//  NetUchidakTiflatuikitView.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/12.
//
//

#import "NetUchidakTiflatuikitButton.h"
#import "TiUtils.h"
#import "TiUIButton.h"
#import "TiButtonUtil.h"
#import "TiUIView.h"

@implementation NetUchidakTiflatuikitButton

-(FUIButton*)button
{
    if(button==nil){
        button = [[FUIButton alloc] initWithFrame:[self frame]];
        button.frame = CGRectMake(0, 0, 200, 50);
		[button addTarget:self action:@selector(controlAction:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
		button.exclusiveTouch = YES;
        [self addSubview:button];
    }
    return button;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (button!=nil)
    {
        [TiUtils setView:button positionRect:bounds];
    }
}

-(void)setButtonColor_:(id)value
{
    UIColor *c = [[TiUtils colorValue:value] _color];
    FUIButton *b = [self button];
    b.buttonColor = c;
}

-(void)setShadowColor_:(id)value
{
    UIColor *c = [[TiUtils colorValue:value] _color];
    FUIButton *b = [self button];
    b.shadowColor = c;
}

-(void)setShadowHeight_:(id)value
{
    CGFloat f = [TiUtils floatValue:value];
    FUIButton *b = [self button];
    b.shadowHeight = f;
}

-(void)setCornerRadius_:(id)value
{
    CGFloat f = [TiUtils floatValue:value];
    FUIButton *b = [self button];
    b.cornerRadius = f;
}

-(void)setTitle_:(id)value
{
    NSString  *s = [TiUtils stringValue:value];
    FUIButton *b = [self button];
    [b setTitle:s forState:(UIControlStateNormal)];
}

-(void)setColor_:(id)value
{
    UIColor  *c = [[TiUtils colorValue:value] _color];
    FUIButton *b = [self button];
    [b setTitleColor:c forState:UIControlStateNormal];
}

-(void)setSelectedColor_:(id)value
{
    UIColor  *c = [[TiUtils colorValue:value] _color];
    FUIButton *b = [self button];
    [b setTitleColor:c forState:UIControlStateHighlighted];
}

-(void)setFont_:(id)value
{
    WebFont  *f = [TiUtils fontValue:value def:nil];
    FUIButton *b = [self button];
    [[b titleLabel] setFont:[f font]];
}

-(void)setEnabled_:(id)value
{
	[[self button] setEnabled:[TiUtils boolValue:value]];
}

- (void)controlAction:(id)sender forEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    NSString *fireEvent;
    NSString * fireActionEvent = nil;
    switch (touch.phase) {
        case UITouchPhaseBegan:
            if (touchStarted) {
                return;
            }
            touchStarted = YES;
            fireEvent = @"touchstart";
            break;
        case UITouchPhaseMoved:
            fireEvent = @"touchmove";
            break;
        case UITouchPhaseEnded:
            touchStarted = NO;
            fireEvent = @"touchend";
            if (button.highlighted) {
                fireActionEvent = [touch tapCount] == 1 ? @"click" : ([touch tapCount] == 2 ? @"dblclick" : nil);
            }
            break;
        case UITouchPhaseCancelled:
            touchStarted = NO;
            fireEvent = @"touchcancel";
            break;
        default:
            return;
    }
    NSMutableDictionary *evt = [NSMutableDictionary dictionaryWithDictionary:[TiUtils pointToDictionary:[touch locationInView:self]]];
    if ((fireActionEvent != nil) && [self.proxy _hasListeners:fireActionEvent]) {
        [self.proxy fireEvent:fireActionEvent withObject:evt];
    }
	if ([self.proxy _hasListeners:fireEvent]) {
		[self.proxy fireEvent:fireEvent withObject:evt];
	}
}
@end
