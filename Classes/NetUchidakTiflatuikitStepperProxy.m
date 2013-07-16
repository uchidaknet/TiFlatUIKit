//
//  NetUchidakTiflatuikitStepperProxy.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/16.
//
//

#import "NetUchidakTiflatuikitStepperProxy.h"

NSArray* stepperKeySequence;

@implementation NetUchidakTiflatuikitStepperProxy

-(NSArray *)keySequence
{
	if (stepperKeySequence == nil)
	{
		stepperKeySequence = [NSArray arrayWithObjects:@"min",@"max",@"value",nil] ;
	}
	return stepperKeySequence;
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
