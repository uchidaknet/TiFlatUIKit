//
//  NetUchidakTiflatuikitSwitch.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/16.
//
//

#import "NetUchidakTiflatuikitSwitch.h"
#import "TiUtils.h"
#import "UIColor+FlatUI.h"
#import "TiViewProxy.h"

@implementation NetUchidakTiflatuikitSwitch

-(FUISwitch*)switchView
{
	if (switchView==nil)
	{
		switchView = [[FUISwitch alloc] initWithFrame:[self frame]];
        switchView.frame = CGRectMake(0, 0, 200, 50);
        [switchView setOnColor:[UIColor alizarinColor]];
        [switchView setOffColor:[UIColor silverColor]];
        [switchView setOnBackgroundColor:[UIColor tangerineColor]];
        [switchView setOffBackgroundColor:[UIColor nephritisColor]];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
		[self addSubview:switchView];
	}
	return switchView;
}

- (id)accessibilityElement
{
	return [self switchView];
}

-(BOOL)hasTouchableListener
{
	return YES;
}

#pragma mark View controller stuff

-(void)setEnabled_:(id)value
{
	[[self switchView] setEnabled:[TiUtils boolValue:value]];
}

-(void)setValue_:(id)value
{
	BOOL reproxying = [self.proxy inReproxy];
	BOOL newValue = [TiUtils boolValue:value];
	BOOL animated = !reproxying;
	FUISwitch* ourSwitch = [self switchView];
    if ([ourSwitch isOn] == newValue) {
        return;
    }
	[ourSwitch setOn:newValue animated:animated];
	
	if ((reproxying == NO) && configurationSet && [self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:value forKey:@"value"]];
	}
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (switchView!=nil)
    {
        [TiUtils setView:switchView positionRect:bounds];
    }
}

- (IBAction)switchChanged:(id)sender
{
	NSNumber * newValue = [NSNumber numberWithBool:[(FUISwitch *)sender isOn]];
	[self.proxy replaceValue:newValue forKey:@"value" notification:NO];
	
	if ([self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
	}
}

#pragma mark Switch Style

-(void)setOnColor_:(id)value
{
    UIColor* c = [[TiUtils colorValue:value] _color];
    FUISwitch* s = [self switchView];
    [s setOnColor:c];
}

-(void)setOffColor_:(id)value
{
    UIColor* c = [[TiUtils colorValue:value] _color];
    FUISwitch* s = [self switchView];
    [s setOffColor:c];
}

-(void)setOnBackgroundColor_:(id)value
{
    UIColor* c = [[TiUtils colorValue:value] _color];
    FUISwitch* s = [self switchView];
    [s setOnBackgroundColor:c];
}

-(void)setOffBackgroundColor_:(id)value
{
    UIColor* c = [[TiUtils colorValue:value] _color];
    FUISwitch* s = [self switchView];
    [s setOffBackgroundColor:c];
}

-(void)setOnLabelFont_:(id)value
{
    WebFont* f = [TiUtils fontValue:value def:nil];
    FUISwitch* s = [self switchView];
    UILabel* l = [s onLabel];
    [l setFont:[f font]];
}

-(void)setOffLabelFont_:(id)value
{
    WebFont* f = [TiUtils fontValue:value def:nil];
    FUISwitch* s = [self switchView];
    UILabel* l = [s offLabel];
    [l setFont:[f font]];
}

-(void)setOnLabel_:(id)value
{
    NSString* v = [TiUtils stringValue:value];
    FUISwitch* s = [self switchView];
    UILabel* l = [s onLabel];
    [l setText:v];
}

-(void)setOffLabel_:(id)value{
    NSString* v = [TiUtils stringValue:value];
    FUISwitch* s = [self switchView];
    UILabel* l = [s offLabel];
    [l setText:v];
}

@end
