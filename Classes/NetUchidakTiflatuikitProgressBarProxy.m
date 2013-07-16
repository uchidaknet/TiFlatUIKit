//
//  NetUchidakTiflatuikitProgressBarProxy.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/16.
//
//

#import "NetUchidakTiflatuikitProgressBarProxy.h"
#import "NetUchidakTiflatuikitProgressBar.h"
#import "TiUtils.h"

@implementation NetUchidakTiflatuikitProgressBarProxy

-(TiUIView*)newView
{
    return [[NetUchidakTiflatuikitProgressBar alloc] init];
}

-(TiDimension)defaultAutoWidthBehavior:(id)unused
{
    return TiDimensionAutoSize;
}
-(TiDimension)defaultAutoHeightBehavior:(id)unused
{
    return TiDimensionAutoSize;
}

@end
