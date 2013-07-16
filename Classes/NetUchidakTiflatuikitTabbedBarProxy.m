//
//  NetUchidakTiflatuikitTabbedBarProxy.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/14.
//
//

#import "NetUchidakTiflatuikitTabbedBarProxy.h"

@implementation NetUchidakTiflatuikitTabbedBarProxy

-(void)fireEvent:(NSString*)type withObject:(id)obj propagate:(BOOL)propagate reportSuccess:(BOOL)report errorCode:(int)code message:(NSString*)message;
{
	if (![TiUtils boolValue:[self valueForKey:@"enabled"] def:YES])
	{
		return;
	}
	[super fireEvent:type withObject:obj propagate:propagate reportSuccess:report errorCode:code message:message];
}

@end
