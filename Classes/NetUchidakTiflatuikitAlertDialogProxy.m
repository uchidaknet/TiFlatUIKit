//
//  NetUchidakTiflatuikitAlertDialogProxy.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/14.
//
//

#import "NetUchidakTiflatuikitAlertDialogProxy.h"
#import "TiUtils.h"

static NSCondition* alertCondition;
static BOOL alertShowing = NO;

@implementation NetUchidakTiflatuikitAlertDialogProxy


-(void)cleanup
{
	if(alert != nil)
	{
		[alertCondition lock];
		alertShowing = NO;
        persistentFlag = NO;
		[alertCondition broadcast];
		[alertCondition unlock];
		[self forgetSelf];
		[[NSNotificationCenter defaultCenter] removeObserver:self];
	}
}

-(void)hide:(id)args
{
	ENSURE_SINGLE_ARG_OR_NIL(args,NSDictionary);
	ENSURE_UI_THREAD_1_ARG(args);
	
	if (alert!=nil)
	{
		[alert setDelegate:nil];
		BOOL animated = [TiUtils boolValue:@"animated" properties:args def:YES];
		[alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:animated];
		[self cleanup];
	}
}

-(void)show:(id)args
{
	if (alertCondition==nil)
	{
		alertCondition = [[NSCondition alloc] init];
	}
	
	if ([NSThread isMainThread]==NO)
	{
		[self rememberSelf];
		
		[alertCondition lock];
		if (alertShowing)
		{
			[alertCondition wait];
		}
		alertShowing = YES;
		[alertCondition unlock];
		TiThreadPerformOnMainThread(^{[self show:args];}, YES);
	}
	else
	{
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(suspended:) name:kTiSuspendNotification object:nil];
		
		NSMutableArray *buttonNames = [self valueForKey:@"buttonNames"];
		if (buttonNames==nil || (id)buttonNames == [NSNull null])
		{
			buttonNames = [[NSMutableArray alloc] initWithCapacity:2];
			NSString *ok = [self valueForUndefinedKey:@"ok"];
			if (ok==nil)
			{
				ok = @"OK";
			}
			[buttonNames addObject:ok];
		}
		persistentFlag = [TiUtils boolValue:[self valueForKey:@"persistent"] def:NO];
		alert = [[FUIAlertView alloc] initWithTitle:[TiUtils stringValue:[self valueForKey:@"title"]]
                                            message:[TiUtils stringValue:[self valueForKey:@"message"]]
                                           delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        
        [[alert titleLabel] setTextColor:[[TiUtils colorValue:[self valueForKey:@"titleColor"]] _color]];
        [[alert messageLabel] setTextColor:[[TiUtils colorValue:[self valueForKey:@"messageColor"]] _color]];
        [[alert backgroundOverlay] setBackgroundColor:[[TiUtils colorValue:[self valueForKey:@"overlayColor"]] _color]];
        [[alert alertContainer] setBackgroundColor:[[TiUtils colorValue:[self valueForKey:@"backgroundColor"]] _color]];
        
        [[alert titleLabel] setFont:[[TiUtils fontValue:[self valueForKey:@"titleFont"] def:nil] font]];
        [[alert messageLabel] setFont:[[TiUtils fontValue:[self valueForKey:@"messageFont"] def:nil] font]];
        
        [alert setDefaultButtonColor:[[TiUtils colorValue:[self valueForKey:@"defaultButtonColor"]] _color]];
        [alert setDefaultButtonShadowColor:[[TiUtils colorValue:[self valueForKey:@"defaultButtonShadowColor"]] _color]];
        [alert setDefaultButtonTitleColor:[[TiUtils colorValue:[self valueForKey:@"defaultButtonTitleColor"]] _color]];
        [alert setDefaultButtonFont:[[TiUtils fontValue:[self valueForKey:@"buttonFont"] def:nil] font]];

        [alert setCancelButtonColor:[[TiUtils colorValue:[self valueForKey:@"cancelButtonColor"]] _color]];
        [alert setCancelButtonShadowColor:[[TiUtils colorValue:[self valueForKey:@"cancelButtonShadowColor"]] _color]];
        [alert setCancelButtonTitleColor:[[TiUtils colorValue:[self valueForKey:@"cancelButtonTitleColor"]] _color]];

        NSInteger i = 0;
        NSInteger cancelIndex = [TiUtils intValue:[self valueForKey:@"cancel"] def:-1];
		for (id btn in buttonNames)
		{
			NSString * thisButtonName = [TiUtils stringValue:btn];
            if(i == cancelIndex){
                [alert addButtonWithTitle:thisButtonName mode:CONST_BUTTON_MODE_CANCEL];
            } else {
                [alert addButtonWithTitle:thisButtonName mode:CONST_BUTTON_MODE_DEFAULT];
            }
            i++;
		}
        
		[alert setCancelButtonIndex:cancelIndex];
        
		[alert show];
	}
}

-(void)suspended:(NSNotification*)note
{
    if (!persistentFlag) {
        [self hide:[NSDictionary dictionaryWithObject:NUMBOOL(NO) forKey:@"animated"]];
    }
}

-(void)alertViewCancel:(FUIAlertView *)alertView
{
    if (!persistentFlag) {
        [self hide:[NSDictionary dictionaryWithObject:NUMBOOL(NO) forKey:@"animated"]];
    }
}

#pragma mark AlertView Delegate

-(void)alertView:(FUIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	[self cleanup];
}

- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ([self _hasListeners:@"click"])
	{
		NSMutableDictionary *event = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:buttonIndex],@"index",
                                      [NSNumber numberWithInt:[alertView cancelButtonIndex]],@"cancel",
                                      nil];
        
		[self fireEvent:@"click" withObject:event];
	}
}


@end
