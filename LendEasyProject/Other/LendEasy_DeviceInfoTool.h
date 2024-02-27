//
//  CADeviceInfoTool.h
//  cashACEProject
//
//  Created by Apple on 2023/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LendEasy_DeviceInfoTool : NSObject
-(long long)CA_getTotalMemorySize;
-(long long)CA_getAvailableMemorySize;
-(long long)CA_getTotalDiskSize;
-(long long)CA_getAvailableDiskSize;
-(float)CA_getRealSize;
-(NSString *)CA_ifSimulator;
-(NSString *)CA_isJailBreak;
- (NSString *)CA_isOpenTheProxy;
- (NSString *)CA_isVPNOn;
-(NSString *)CA_getcarrierName;
- (NSString *)CA_getNetconnType;
-(NSString *)CA_getIPAddress;
- (NSDictionary *)CA_fetchSSIDInfo;
-(NSString *)CA_getCurrentDeviceInch;
@end

NS_ASSUME_NONNULL_END
