//
//  NetUchidakTiflatuikitSlider.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/15.
//
//

#import "NetUchidakTiflatuikitSlider.h"
#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "TiUtils.h"
#import "UIImage+FlatUI.h"

@implementation NetUchidakTiflatuikitSlider

-(UISlider*)sliderView
{
	if (sliderView==nil)
	{
		sliderView = [[UISlider alloc] initWithFrame:[self bounds]];

        [sliderView configureFlatSliderWithTrackColor:[UIColor silverColor]
                                        progressColor:[UIColor silverColor]
                                           thumbColor:[UIColor silverColor]];
		
		[sliderView setValue:0.1 animated:NO];
		[sliderView setValue:0 animated:NO];
		
		[sliderView addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
		[sliderView addTarget:self action:@selector(sliderBegin:) forControlEvents:UIControlEventTouchDown];
		[sliderView addTarget:self action:@selector(sliderEnd:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel)];
		[self addSubview:sliderView];
		lastTouchUp = [[NSDate alloc] init];
		lastTimeInterval = 1.0;
		
		thumbImageState = UIControlStateNormal;
		leftTrackImageState = UIControlStateNormal;
		rightTrackImageState = UIControlStateNormal;
	}
	return sliderView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [sliderView setFrame:[self bounds]];
}

- (id)accessibilityElement
{
	return [self sliderView];
}

-(BOOL)hasTouchableListener
{
	return YES;
}

-(void)setThumb:(id)value forState:(UIControlState)state
{
	[[self sliderView] setThumbImage:[TiUtils image:value proxy:[self proxy]] forState:state];
}

#pragma mark View controller stuff

-(void)setLeftTrackLeftCap_:(id)value
{
	leftTrackLeftCap = TiDimensionFromObject(value);
}

-(void)setLeftTrackTopCap_:(id)value
{
	leftTrackTopCap = TiDimensionFromObject(value);
}

-(void)setRightTrackLeftCap_:(id)value
{
    rightTrackLeftCap = TiDimensionFromObject(value);
}

-(void)setRightTrackTopCap_:(id)value
{
	rightTrackTopCap = TiDimensionFromObject(value);
}

-(void)setTrackColor_:(id)value
{
	trackColor = [[TiUtils colorValue:value] _color];
    UIImage *trackImage = [[UIImage imageWithColor:trackColor cornerRadius:5.0]
                           imageWithMinimumSize:CGSizeMake(10, 10)];
    [sliderView setMaximumTrackImage:trackImage forState:UIControlStateNormal];
}

-(void)setProgressColor_:(id)value
{
	progressColor = [[TiUtils colorValue:value] _color];
    UIImage *progressImage = [[UIImage imageWithColor:progressColor cornerRadius:5.0]
                              imageWithMinimumSize:CGSizeMake(10, 10)];
    [sliderView setMinimumTrackImage:progressImage forState:UIControlStateNormal];
    
}

-(void)setThumbColor_:(id)value
{
	thumbColor = [[TiUtils colorValue:value] _color];
    UIImage *normalSliderImage = [UIImage circularImageWithColor:thumbColor size:CGSizeMake(24, 24)];
    [sliderView setThumbImage:normalSliderImage forState:UIControlStateNormal];
    
    UIImage *highlighedSliderImage = [UIImage circularImageWithColor:thumbColor size:CGSizeMake(24, 24)];
    [sliderView setThumbImage:highlighedSliderImage forState:UIControlStateHighlighted];
}

-(void)setMin_:(id)value
{
	[[self sliderView] setMinimumValue:[TiUtils floatValue:value]];
}

-(void)setMax_:(id)value
{
	[[self sliderView] setMaximumValue:[TiUtils floatValue:value]];
}

-(void)setValue_:(id)value withObject:(id)properties
{
	CGFloat newValue = [TiUtils floatValue:value];
	BOOL animated = [TiUtils boolValue:@"animated" properties:properties def:NO];
	UISlider * ourSlider = [self sliderView];
	[ourSlider setValue:newValue animated:animated];
	[self sliderChanged:ourSlider];
}

-(void)setValue_:(id)value
{
	[self setValue_:value withObject:nil];
}

-(void)setEnabled_:(id)value
{
	[[self sliderView] setEnabled:[TiUtils boolValue:value]];
}

-(CGFloat)verifyHeight:(CGFloat)suggestedHeight
{
	CGSize fitSize = [[self sliderView] sizeThatFits:CGSizeZero];
	return fitSize.height;
}

#pragma mark Delegates

- (IBAction)sliderChanged:(id)sender
{
	NSNumber * newValue = [NSNumber numberWithFloat:[(UISlider *)sender value]];
	[self.proxy replaceValue:newValue forKey:@"value" notification:NO];
	
	if ([self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
	}
}

-(IBAction)sliderBegin:(id)sender
{
    NSNumber * newValue = [NSNumber numberWithFloat:[(UISlider*)sender value]];
    if ([[self proxy] _hasListeners:@"touchstart"])
    {
        [[self proxy] fireEvent:@"touchstart" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
    }
    if ([[self proxy] _hasListeners:@"start"])
    {
        [[self proxy] fireEvent:@"start" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"] propagate:NO reportSuccess:NO errorCode:0 message:nil];
    }
}

-(IBAction)sliderEnd:(id)sender
{
    NSDate* now = [[NSDate alloc] init];
    NSTimeInterval currentTimeInterval = [now timeIntervalSinceDate:lastTouchUp];
    if (!(lastTimeInterval < 0.1 && currentTimeInterval < 0.1)) {
        NSNumber * newValue = [NSNumber numberWithFloat:[(UISlider*)sender value]];
        if ([[self proxy] _hasListeners:@"touchend"])
        {
            [[self proxy] fireEvent:@"touchend" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
        }
        if ([[self proxy] _hasListeners:@"stop"])
        {
            [[self proxy] fireEvent:@"stop" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"] propagate:NO reportSuccess:NO errorCode:0 message:nil];
        }
    }
    lastTimeInterval = currentTimeInterval;
    lastTouchUp = now;
}

@end
