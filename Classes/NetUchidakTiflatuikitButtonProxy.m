//
//  NetUchidakTiflatuikitButtonProxy.m
//  TiFlatUIKit
//
//  Created by Keisuke Uchida on 2013/07/12.
//
//

#import "NetUchidakTiflatuikitButtonProxy.h"

@implementation NetUchidakTiflatuikitButtonProxy

-(void)fireEvent:(NSString*)type withObject:(id)obj propagate:(BOOL)propagate reportSuccess:(BOOL)report errorCode:(int)code message:(NSString*)message;
{
	if (![TiUtils boolValue:[self valueForKey:@"enabled"] def:YES])
	{
		return;
	}
	[super fireEvent:type withObject:obj propagate:propagate reportSuccess:report errorCode:code message:message];
}

@end
