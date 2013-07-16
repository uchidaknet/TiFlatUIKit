//
//  NetUchidakTiflatuikitSwitch.h
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/16.
//
//

#import "TiUIView.h"
#import "FUISwitch.h"

@interface NetUchidakTiflatuikitSwitch : TiUIView<LayoutAutosizing> {
    	FUISwitch *switchView;
}

- (IBAction)switchChanged:(id)sender;

@end
