//
//  NetUchidakTiflatuikitStepper.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/16.
//
//

#import "NetUchidakTiflatuikitStepper.h"
#import "TiUtils.h"
#import "UIStepper+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIImage+FlatUI.h"

@implementation NetUchidakTiflatuikitStepper

-(UIStepper*)stepperView
{
	if (stepperView==nil)
	{
		stepperView = [[UIStepper alloc] initWithFrame:[self frame]];
        stepperView.frame = CGRectMake(0, 0, 94, 27);

        [stepperView configureFlatStepperWithColor:[UIColor silverColor]
                                  highlightedColor:[UIColor silverColor]
                                     disabledColor:[UIColor silverColor]
                                         iconColor:[UIColor silverColor]];
        
		[stepperView setValue:0.1];
		[stepperView setValue:1.0];
		
		[stepperView addTarget:self action:@selector(stepperChanged:) forControlEvents:UIControlEventValueChanged];

		[self addSubview:stepperView];
	}
	return stepperView;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (stepperView!=nil)
    {
        [TiUtils setView:stepperView positionRect:bounds];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [stepperView setFrame:[self bounds]];
}

- (id)accessibilityElement
{
	return [self stepperView];
}

-(BOOL)hasTouchableListener
{
	return YES;
}

#pragma mark property

-(void)setColor_:(id)value
{
    UIColor* newColor = [[TiUtils colorValue:value] _color];
    UIImage* normalImage = [UIImage imageWithColor:newColor cornerRadius:2.0];
    UIStepper* stepper = [self stepperView];
    [stepper setBackgroundImage:normalImage forState:UIControlStateNormal];
}

-(void)setHighlightedColor_:(id)value
{
    UIColor* newColor = [[TiUtils colorValue:value] _color];
    UIImage *highlightedImage = [UIImage imageWithColor:newColor cornerRadius:2.0];
    UIImage *dividerImage = [UIImage imageWithColor:newColor cornerRadius:0];
    UIStepper* stepper = [self stepperView];
    [stepper setBackgroundImage:highlightedImage
                       forState:UIControlStateHighlighted];
    [stepper setDividerImage:dividerImage
         forLeftSegmentState:UIControlStateNormal
           rightSegmentState:UIControlStateNormal];
    [stepper setDividerImage:dividerImage
         forLeftSegmentState:UIControlStateHighlighted
           rightSegmentState:UIControlStateNormal];
    [stepper setDividerImage:dividerImage
         forLeftSegmentState:UIControlStateNormal
           rightSegmentState:UIControlStateHighlighted];
}

-(void)setDisabledColor_:(id)value
{
    UIColor* newColor = [[TiUtils colorValue:value] _color];
    UIImage *disabledImage = [UIImage imageWithColor:newColor cornerRadius:2.0];
    UIStepper* stepper = [self stepperView];
    [stepper setBackgroundImage:disabledImage forState:UIControlStateDisabled];
}

-(void)setMinusIconColor_:(id)value
{
    UIColor* newColor = [[TiUtils colorValue:value] _color];
    UIImage *minusImage = [UIImage stepperMinusImageWithColor:newColor];
    UIStepper* stepper = [self stepperView];
    [stepper setDecrementImage:minusImage forState:UIControlStateNormal];
    [stepper setDecrementImage:minusImage forState:UIControlStateDisabled];
}

-(void)setPlusIconColor_:(id)value
{
    UIColor* newColor = [[TiUtils colorValue:value] _color];
    UIImage *plusImage = [UIImage stepperPlusImageWithColor:newColor];
    UIStepper* stepper = [self stepperView];
    [stepper setIncrementImage:plusImage forState:UIControlStateNormal];
    [stepper setIncrementImage:plusImage forState:UIControlStateDisabled];
}

-(void)setMin_:(id)value
{
	[[self stepperView] setMinimumValue:[TiUtils floatValue:value]];
}

-(void)setMax_:(id)value
{
	[[self stepperView] setMaximumValue:[TiUtils floatValue:value]];
}

-(void)setStepValue_:(id)value
{
	[[self stepperView] setStepValue:[TiUtils floatValue:value]];
}

-(void)setValue_:(id)value withObject:(id)properties
{
	CGFloat newValue = [TiUtils floatValue:value];
	UIStepper * ourStepper = [self stepperView];
	[ourStepper setValue:newValue];
	[self stepperChanged:ourStepper];
}

-(void)setValue_:(id)value
{
	[self setValue_:value withObject:nil];
}

-(void)setEnabled_:(id)value
{
	[[self stepperView] setEnabled:[TiUtils boolValue:value]];
}

-(CGFloat)verifyHeight:(CGFloat)suggestedHeight
{
	CGSize fitSize = [[self stepperView] sizeThatFits:CGSizeZero];
	return fitSize.height;
}

#pragma mark Delegates

- (IBAction)stepperChanged:(id)sender
{
	NSNumber * newValue = [NSNumber numberWithFloat:[(UIStepper *)sender value]];
	[self.proxy replaceValue:newValue forKey:@"value" notification:NO];
	
	if ([self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
	}
}

@end
