//
//  NetUchidakTiflatuikitProgressBar.h
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/16.
//
//

#import "TiUIView.h"

@interface NetUchidakTiflatuikitProgressBar : TiUIView
{
    UIProgressView *progress;
	UIProgressViewStyle style;
    CGFloat max;
    CGFloat min;
    
    BOOL requiresLayout;
    UILabel * messageLabel;
}
@end
