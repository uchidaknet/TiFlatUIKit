//
//  NetUchidakTiflatuikitSliderProxy.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/15.
//
//

#import "NetUchidakTiflatuikitSliderProxy.h"

NSArray* sliderKeySequence;

@implementation NetUchidakTiflatuikitSliderProxy

-(NSArray *)keySequence
{
	if (sliderKeySequence == nil)
	{
		sliderKeySequence = [NSArray arrayWithObjects:@"min",@"max",@"value",@"leftTrackLeftCap",@"leftTrackTopCap",@"rightTrackLeftCap",@"rightTrackTopCap",nil] ;
	}
	return sliderKeySequence;
}

-(void)_initWithProperties:(NSDictionary *)properties
{
    [self initializeProperty:@"leftTrackLeftCap" defaultValue:NUMFLOAT(1.0)];
    [self initializeProperty:@"leftTrackTopCap" defaultValue:NUMFLOAT(1.0)];
    [self initializeProperty:@"rightTrackLeftCap" defaultValue:NUMFLOAT(1.0)];
    [self initializeProperty:@"rightTrackTopCap" defaultValue:NUMFLOAT(1.0)];
    [super _initWithProperties:properties];
}

-(UIViewAutoresizing)verifyAutoresizing:(UIViewAutoresizing)suggestedResizing
{
	return suggestedResizing & ~UIViewAutoresizingFlexibleHeight;
}

-(TiDimension)defaultAutoHeightBehavior:(id)unused
{
    return TiDimensionAutoSize;
}
@end
