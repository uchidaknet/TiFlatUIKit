//
//  NetUchidakTiflatuikitAlertDialogProxy.h
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/14.
//
//

#import "TiProxy.h"
#import "FUIAlertView.h"

@interface NetUchidakTiflatuikitAlertDialogProxy : TiProxy<FUIAlertViewDelegate>{
    FUIAlertView *alert;
    BOOL persistentFlag;
}

@end
