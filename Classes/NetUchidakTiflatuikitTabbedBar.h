//
//  NetUchidakTiflatuikitTabbedBar.h
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/14.
//
//

#import "TiUIView.h"
#import "FUISegmentedControl.h"

@interface NetUchidakTiflatuikitTabbedBar : TiUIView<LayoutAutosizing>
{
    int selectedIndex;
    FUISegmentedControl* segmentedControl;
    BOOL controlSpecifiedWidth;
}
@end
