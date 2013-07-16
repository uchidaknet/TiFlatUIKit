//
//  NetUchidakTiflatuikitTabbedBar.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/14.
//
//

#import "NetUchidakTiflatuikitTabbedBar.h"
#import "TiUtils.h"
#import "FUISegmentedControl.h"
#import "TiViewProxy.h"

@implementation NetUchidakTiflatuikitTabbedBar

-(id)init
{
	self = [super init];
	if (self != nil)
	{
		selectedIndex = -1;
	}
	return self;
}

-(FUISegmentedControl *)segmentedControl
{
    if(segmentedControl==nil){
		CGRect ourBoundsRect = [self bounds];
		segmentedControl=[[FUISegmentedControl alloc] initWithFrame:ourBoundsRect];
		[segmentedControl setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
		[segmentedControl addTarget:self action:@selector(onSegmentChange:) forControlEvents:UIControlEventValueChanged];
		[self addSubview:segmentedControl];
    }
    return segmentedControl;
}

-(void)frameSizeChanged:(CGRect)frame_ bounds:(CGRect)bounds_
{
    FUISegmentedControl* ourControl = [self segmentedControl];
    if (controlSpecifiedWidth && TiDimensionIsUndefined([(TiViewProxy*)[self proxy] layoutProperties]->width)) {
        CGRect controlBounds = bounds_;
        controlBounds.size = [ourControl sizeThatFits:CGSizeZero];
        [ourControl setBounds:controlBounds];
    }
    else {
        [ourControl setFrame:bounds_];
    }
    [super frameSizeChanged:frame_ bounds:bounds_];
}

-(void)setBackgroundColor_:(id)value
{
	TiColor *color = [TiUtils colorValue:value];
	[[self segmentedControl] setTintColor:[color _color]];
}

-(void)setIndex_:(id)value
{
	selectedIndex = [TiUtils intValue:value def:-1];
	[[self segmentedControl] setSelectedSegmentIndex:selectedIndex];
}

-(IBAction)onSegmentChange:(id)sender
{
	int newIndex = [(FUISegmentedControl *)sender selectedSegmentIndex];
	
	[self.proxy replaceValue:NUMINT(newIndex) forKey:@"index" notification:NO];
	
	if (newIndex == selectedIndex)
	{
		return;
	}
    
	selectedIndex = newIndex;
    
	if ([self.proxy _hasListeners:@"click"])
	{
		NSDictionary *event = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:selectedIndex] forKey:@"index"];
		[self.proxy fireEvent:@"click" withObject:event];
	}
	
	if ([(FUISegmentedControl *)sender isMomentary])
	{
		selectedIndex = -1;
		[self.proxy replaceValue:NUMINT(-1) forKey:@"index" notification:NO];
	}
}

-(void)setLabels_:(id)value
{
	[[self segmentedControl] removeAllSegments];
	if (IS_NULL_OR_NIL(value)) {
		return;
	}
	ENSURE_ARRAY(value);
    
	int thisSegmentIndex = 0;
	controlSpecifiedWidth = YES;
	for (id thisSegmentEntry in value)
	{
		NSString * thisSegmentTitle = [TiUtils stringValue:thisSegmentEntry];
		UIImage * thisSegmentImage = nil;
		CGFloat thisSegmentWidth = 0;
		BOOL thisSegmentEnabled = YES;
		NSString *thisSegmentAccessibilityLabel = nil;
		
		if ([thisSegmentEntry isKindOfClass:[NSDictionary class]])
		{
			thisSegmentTitle = [TiUtils stringValue:@"title" properties:thisSegmentEntry];
			thisSegmentImage = [TiUtils image:[thisSegmentEntry objectForKey:@"image"] proxy:[self proxy]];
			thisSegmentWidth = [TiUtils floatValue:@"width" properties:thisSegmentEntry];
			thisSegmentEnabled = [TiUtils boolValue:@"enabled" properties:thisSegmentEntry def:YES];
			thisSegmentAccessibilityLabel = [TiUtils stringValue:@"accessibilityLabel" properties:thisSegmentEntry];
		}
        
		if (thisSegmentImage != nil)
		{
			if (thisSegmentAccessibilityLabel != nil) {
				thisSegmentImage.accessibilityLabel = thisSegmentAccessibilityLabel;
			}
			[segmentedControl insertSegmentWithImage:thisSegmentImage atIndex:thisSegmentIndex animated:NO];
		}
		else
		{
			if (thisSegmentTitle == nil)
			{
				thisSegmentTitle = @"";
			}
			if (thisSegmentAccessibilityLabel != nil) {
				thisSegmentTitle.accessibilityLabel = thisSegmentAccessibilityLabel;
			}
			[segmentedControl insertSegmentWithTitle:thisSegmentTitle atIndex:thisSegmentIndex animated:NO];
		}
        
		[segmentedControl setWidth:thisSegmentWidth forSegmentAtIndex:thisSegmentIndex];
		[segmentedControl setEnabled:thisSegmentEnabled forSegmentAtIndex:thisSegmentIndex];
		thisSegmentIndex ++;
		controlSpecifiedWidth &= (thisSegmentWidth != 0.0);
	}
    
	if (![segmentedControl isMomentary])
	{
		[segmentedControl setSelectedSegmentIndex:selectedIndex];
	}
    
}

-(void)setSelectedFont_:(id)value
{
    WebFont  *f = [TiUtils fontValue:value def:nil];
    FUISegmentedControl *b = [self segmentedControl];
    [b setSelectedFont:[f font]];
}

-(void)setSelectedFontColor_:(id)value
{
    UIColor  *c = [[TiUtils colorValue:value] _color];
    FUISegmentedControl *b = [self segmentedControl];
    [b setSelectedFontColor:c];
}

-(void)setDeselectedFont_:(id)value
{
    WebFont  *f = [TiUtils fontValue:value def:nil];
    FUISegmentedControl *b = [self segmentedControl];
    [b setDeselectedFont:[f font]];
}

-(void)setDeselectedFontColor_:(id)value
{
    UIColor  *c = [[TiUtils colorValue:value] _color];
    FUISegmentedControl *b = [self segmentedControl];
    [b setDeselectedFontColor:c];
}

-(void)setSelectedColor_:(id)value
{
    UIColor  *c = [[TiUtils colorValue:value] _color];
    FUISegmentedControl *b = [self segmentedControl];
    [b setSelectedColor:c];
}

-(void)setDeselectedColor_:(id)value
{
    UIColor  *c = [[TiUtils colorValue:value] _color];
    FUISegmentedControl *b = [self segmentedControl];
    [b setDeselectedColor:c];
}

-(void)setDividerColor_:(id)value
{
    UIColor  *c = [[TiUtils colorValue:value] _color];
    FUISegmentedControl *b = [self segmentedControl];
    [b setDividerColor:c];
}

-(void)setCornerRadius_:(id)value
{
    CGFloat f = [TiUtils floatValue:value];
    FUISegmentedControl *b = [self segmentedControl];
    [b setCornerRadius:f];
}

-(void)setEnabled_:(id)value
{
    FUISegmentedControl *b = [self segmentedControl];
    [b setEnabled:[TiUtils boolValue:value]];
}

-(CGFloat)contentWidthForWidth:(CGFloat)suggestedWidth
{
	return [[self segmentedControl] sizeThatFits:CGSizeZero].width;
}

-(CGFloat)contentHeightForWidth:(CGFloat)width
{
	return [[self segmentedControl] sizeThatFits:CGSizeZero].height;
}

@end
