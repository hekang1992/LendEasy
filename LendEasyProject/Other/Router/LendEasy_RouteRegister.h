//
//  YBRouteRegister.h
//  AFNetworking
//
//  Created by LQ on 2018/7/17.
//

#import <Foundation/Foundation.h>
@protocol KIRouteRegisterProtocol

@required

- (void)enroll;

@end

@interface LendEasy_RouteRegister : NSObject <KIRouteRegisterProtocol>


+ (void)enroll:(NSArray<__kindof NSString*>*)modules;


@end

