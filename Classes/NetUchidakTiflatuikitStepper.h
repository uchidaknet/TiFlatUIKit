//
//  NetUchidakTiflatuikitStepper.h
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/16.
//
//

#import "TiUIView.h"
#import "UIStepper+FlatUI.h"

@interface NetUchidakTiflatuikitStepper : TiUIView<LayoutAutosizing>
{
    UIStepper *stepperView;
}

- (IBAction)stepperChanged:(id)sender;

@end
