//
//  NetUchidakTiflatuikitSlider.h
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/15.
//
//

#import "TiUIView.h"

@interface NetUchidakTiflatuikitSlider : TiUIView<LayoutAutosizing>
{
	UISlider *sliderView;
	NSDate* lastTouchUp;
	NSTimeInterval lastTimeInterval;
	
	UIControlState thumbImageState;
	UIControlState rightTrackImageState;
	UIControlState leftTrackImageState;
    TiDimension leftTrackLeftCap;
    TiDimension leftTrackTopCap;
    TiDimension rightTrackLeftCap;
    TiDimension rightTrackTopCap;
    
    UIColor* trackColor;
    UIColor* progressColor;
    UIColor* thumbColor;
}

- (IBAction)sliderChanged:(id)sender;

@end
