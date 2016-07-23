//
//  Setting.m
//  TMG_iPhone_GSC
//
//  Created by Sangwook Nam on 9/5/14.
//  Copyright (c) 2014 tionsoft. All rights reserved.
//

#import "Setting.h"

/** @name 회사코드
 *
 *	회사코드 대한 Key 값
 */
//@{
#define kCompanyCodeKey         ( @"CompanyCodeKey" )
#define kCompanyNameKey         ( @"CompanyNameKey" )
//@}

/** @name 개인 설정 셋팅
 *
 *	사용자 언어 설정 및 기본 주소록으로 설정할 속성에 대한 Key 값
 */
//@{
#define kLanguageSettingKey			( @"LanguageSettingKey" )
#define kAddrSettingKey				( @"AddrSettingKey" )
#define kUseOfflineContact			( @"UseOfflineContact" )
#define kOfflineContactUserId		( @"OfflineContactUserId" )
#define kAccountEmailSignatureKey	( @"AccountEmailSignatureKey" )

#define kCantactDownloadDate	( @"CantactDownloadDate" ) // 연락처다운로드
#define kPhoneBookDownloadDate      ( @"PhoneBookDownloadDate" ) // 폰북다운로드

#define kStaff					( @"0" ) // 임직원
#define kContact				( @"1" ) // 연락처
#define kPhonebook				( @"2" ) // 폰북
//@}



/** @name 사용자 정보 저장 용 Key 값들
 *
 *	NSUserDefaults에 사용자 정보를 저장할 때 사용되는 Key 값들
 */
//@{

#define kUserIdSettingKey				( @"UserIdSettingKey" )         ///> 사용자 아이디
#define kUserIdSaveSettingKey			( @"UserIdSaveSettingKey" )     ///> 아이디 저장 유무
#define kUserPasswordSettingKey			( @"UserPasswordSettingKey" )   ///> 사용자 패스워드
#define kUserEmailSettingKey			( @"UserEmailSettingKey" )      ///> 사용자 이메일
#define kUserAuthKey					( @"UserAuthKey" )                  ///> 서버로부터 내려온 어스키

#define kServerIpAddress                ( @"ServerIpAddress" )
#define kServerPort                     ( @"ServerPort" )

#define kNetworkConnectTimeout          ( @"NetworkConnectTimeout" )
#define kNetworkReadTimeout             ( @"NetworkReadTimeout" )

//@}

/** @name 최근 로그인 이력 저장
 *
 *	로그인 이력 대한 Key 값
 */
//@{
#define kLatestLoginName       ( @"LatestLoginName" )
#define kLatestLoginTime       ( @"LatestLoginTime" )
//@}

#define kNotShowNoticeToDay @"NotShowNoticeToDay"


#define kNoticeHtml         @"NoticeHtml"
#define kNoticeId           @"NoticeId"

#define kUserDeptName               @"UserDeptName"
#define kUserGradeName              @"UserGradeName"
#define kUserLevelCode              @"UserLevelCode"
#define kUseGlobalProfile           @"UseGlobalProfile"
#define kHasApprovalDelegate        @"HasApprovalDelegate"

#define kUserProfileImageURL        @"UserProfileImageURL"

#define kPushSettingKey					( @"PushSettingKey" )
#define kPushDeviceTokenSettingKey		( @"PushDeviceTokenSettingKey" )

// 메일 상세 접힘 / 펼침.
#define kMailDetailExpand           ( @"kMailDetailExpand" )
// 결재 상세 접힘 / 펼침.
#define kApprovalDetailExpand       ( @"kApprovalDetailExpand" )
// 게시 상세 접힘 / 펼침.
#define kBoardDetailExpand          ( @"kBoardDetailExpand" )
@implementation Setting


+ (NSString *)languageCode
{
    static NSString *languageCode = nil;
    
    if (languageCode == nil) {
        
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if ([language hasPrefix:@"ko"]) {
            languageCode = @"ko";
        }
        else {
            languageCode = @"en";
        }
    }
    
    return languageCode;
}


// 단말기 언어 설정정보
+ (NSString *)deviceLanguageCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:@"AppleLanguages"] objectAtIndex:0];
}

+ (void)adjustLanguageCode
{
#ifndef FOLLOW_DEVICE_LANGUAGE
    NSString *userLanguage = [Setting languageCode];
//    HKMCLogData(@"userLanguage : %@",userLanguage);
    
    if (userLanguage.length < 1) {
        NSString *deviceLanguage = [Setting deviceLanguageCode];
//        HKMCLogData(@"deviceLanguage : %@", deviceLanguage);
        
        NSArray *localizations = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleLocalizationsKey];
        userLanguage = [localizations indexOfObject:deviceLanguage] == NSNotFound ? @"en" :deviceLanguage;
        [Setting saveLanguageCode:userLanguage];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@[userLanguage] forKey:@"AppleLanguages"];
#endif

}

+ (void)setMailDetailViewExpand:(BOOL)expand
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setValue:[NSNumber numberWithBool:expand] forKey:kMailDetailExpand];
    [standardUserDefaults synchronize];
}

+ (BOOL)isMailDetailViewExpand
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *isExpand = [standardUserDefaults valueForKey:kMailDetailExpand];
    if (isExpand == nil) {
        return YES;
    }
    return [isExpand boolValue];
}

+ (void)setApprovalDetailViewExpand:(BOOL)expand
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setValue:[NSNumber numberWithBool:expand] forKey:kApprovalDetailExpand];
    [standardUserDefaults synchronize];
}

+ (BOOL)isApprovalDetailViewExpand
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *isExpand = [standardUserDefaults valueForKey:kApprovalDetailExpand];
    if (isExpand == nil) {
        return YES;
    }
    return [isExpand boolValue];
}

+ (void)setBoardDetailViewExpand:(BOOL)expand
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setValue:[NSNumber numberWithBool:expand] forKey:kBoardDetailExpand];
    [standardUserDefaults synchronize];
}

+ (BOOL)isBoardDetailViewExpand
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *isExpand = [standardUserDefaults valueForKey:kBoardDetailExpand];
    if (isExpand == nil) {
        return YES;
    }
    return [isExpand boolValue];
}

+ (BOOL)hasPermissionForApproval
{
    BOOL result = NO;
    
    NSString * code = [Setting userLevelCode];
    if( [code length] > 0 ){
        NSInteger codeInt = [code integerValue];
        if( codeInt == 1 )
            result = YES;
    }
    
    return result;
}

+ (BOOL)hasPermissionForSecurityMail
{
    BOOL result = NO;
    
    NSString * code = [Setting userLevelCode];
    if( [code length] > 0 ){
        NSInteger codeInt = [code integerValue];
        if( codeInt == 1 )
            result = YES;
    }

    return result;
}

+ (BOOL)hasPermissionForDocument
{
    BOOL result = NO;
    
    NSString * code = [Setting userLevelCode];
    if( [code length] > 0 ){
        NSInteger codeInt = [code integerValue];
        if( codeInt == 1 || codeInt == 2 )
            result = YES;
    }
    
    return result;
}

//+ (NSString *)ipAddress
//{
//    NSString *ipAddress = [[[NSUserDefaults standardUserDefaults] dataForKey:kIpAddressSettingKey] decryptedString];
//    if (ipAddress.length < 1) {
//        [Setting setIpAddress:kDefaultHostIP];
//        ipAddress = kDefaultHostIP;
//    }
//    return ipAddress;
//}
//
//+ (void)setIpAddress:(NSString *)ipAddress
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:[ipAddress encrypt]forKey:kIpAddressSettingKey];
//    [standardUserDefaults synchronize];
//}
//
//+ (int)port
//{
//    NSString *port = [[[NSUserDefaults standardUserDefaults] dataForKey:kPortSettingKey] decryptedString];
//    if (port.length < 1) {
//        [Setting setPort:[kDefaultHostPort intValue]];
//        port = kDefaultHostPort;
//    }
//    return [port intValue];
//}
//
//+ (void)setPort:(int)port
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:[[@(port) stringValue] encrypt]forKey:kPortSettingKey];
//    [standardUserDefaults synchronize];
//}




//
//
//
//+ (NSString *)localPassword
//{
//    NSString *localPassword = [[[NSUserDefaults standardUserDefaults] dataForKey:kLocalPasswordSettingKey] decryptedString];
//    return localPassword == nil ? @"" : localPassword;
//}
//
//+ (void)setLocalPassword:(NSString *)localPassword
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:[localPassword encrypt]forKey:kLocalPasswordSettingKey];
//    [standardUserDefaults synchronize];
//}
//
//+ (NSString *)phoneNumber
//{
//    NSString *phoneNumber = [[[NSUserDefaults standardUserDefaults] dataForKey:kPhoneNumberSettingKey] decryptedString];
//    return phoneNumber == nil ? @"" : phoneNumber;
//}
//
//+ (void)setPhoneNumber:(NSString *)phoneNumber
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:[phoneNumber encrypt]forKey:kPhoneNumberSettingKey];
//    [standardUserDefaults synchronize];
//}
//
//+ (NSString *)screenLockTime
//{
//    NSString *screenLockTime = [[[NSUserDefaults standardUserDefaults] dataForKey:kSettingDataScreenTimeStringKey] decryptedString];
//    
//    if (screenLockTime.length < 1) {
//        [Setting setScreenLockTime:SETTING_SCREEN_TIME_DEFAULT];
//        return SETTING_SCREEN_TIME_DEFAULT;
//    }
//    return screenLockTime;
//}
//
//+ (void)setScreenLockTime:(NSString *)lockTime
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:[lockTime encrypt]forKey:kSettingDataScreenTimeStringKey];
//    [standardUserDefaults synchronize];
//}
//
//+ (NSString *)lastLocalPasswordCheckDate
//{
//    NSString *lastLocalPasswordCheckDate = [[[NSUserDefaults standardUserDefaults] dataForKey:kLastLocalPasswordCheckKey] decryptedString];
//    return lastLocalPasswordCheckDate == nil ? @"" : lastLocalPasswordCheckDate;
//}
//
//+ (void)setLastLocalPasswordCheckDate:(NSString *)lastLocalPasswordCheckDate
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:[lastLocalPasswordCheckDate encrypt]forKey:kLastLocalPasswordCheckKey];
//    [standardUserDefaults synchronize];
//}
//
//
////+ (NSString *)usePush
////{
////    return [Setting stringFromSettingKey:kUserIdSettingKey];
////}
////
////+ (void)setUsePush:(NSString *)usePush
////{
////    [Setting setValue:usePush settingKey:kSettingDataAlramAllPushBoolKey];
////}
//
//+ (BOOL)usePush
//{
//    BOOL usePush = [[[NSUserDefaults standardUserDefaults] dataForKey:kSettingDataAlramAllPushBoolKey] decryptedInteger];
//    return usePush;
//}
//
//+ (void)setUsePush:(BOOL)usePush
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:[@(usePush) encrypt]forKey:kSettingDataAlramAllPushBoolKey];
//    [standardUserDefaults synchronize];
//}
//
//+ (NSString *)pushStartTime
//{
//    NSString *savedPushStartTime = [Setting stringFromSettingKey:kSettingDataAlramStartDateKey];
//    if (savedPushStartTime.length < 1) {
//        savedPushStartTime = @"08:00:00";
//        [Setting setPushStartTime:savedPushStartTime];
//    }
//    return savedPushStartTime;
//}
//
//+ (void)setPushStartTime:(NSString *)pushStartTime
//{
//    [Setting setValue:pushStartTime settingKey:kSettingDataAlramStartDateKey];
//}
//
//+ (NSString *)pushEndTime
//{
//    NSString *savedPushEndTime = [Setting stringFromSettingKey:kSettingDataAlramEndDateKey];
//    if (savedPushEndTime.length < 1) {
//        savedPushEndTime = @"19:00:00";
//        [Setting setPushEndTime:savedPushEndTime];
//    }
//    return savedPushEndTime;
//}
//
//+ (void)setPushEndTime:(NSString *)pushEndTime
//{
//    [Setting setValue:pushEndTime settingKey:kSettingDataAlramEndDateKey];
//}
//
//+ (void)setDeviceToken:(NSString *)deviceToken
//{
//    [Setting setValue:deviceToken settingKey:kRegisteredDeviceTokenKey];
//}
//
//+ (NSString *)accountId
//{
//    return [Setting stringFromSettingKey:kUserIdSettingKey];
//}
//
//+ (void)setAccountId:(NSString *)accountId
//{
//    [Setting setValue:accountId settingKey:kUserIdSettingKey];
//}
//
//+ (NSString *)accountPassword
//{
//    return [Setting stringFromSettingKey:kUserPasswordSettingKey];
//}
//
//+ (void)setAccountPassword:(NSString *)accountPassword
//{
//    [Setting setValue:accountPassword settingKey:kUserPasswordSettingKey];
//}
//
//+ (NSString *)userProfilePrefix
//{
//    return [Setting stringFromSettingKey:kUserProfileSettingKey];
//}
//
//+ (void)setUserProfilePrefix:(NSString *)userProfilePrefix
//{
//    [Setting setValue:userProfilePrefix settingKey:kUserProfileSettingKey];
//}
//
//+ (NSString *)userEmailSign
//{
//    return [Setting stringFromSettingKey:kUserEmailSignatureKey];
//}
//
//+ (void)setUserEmailSign:(NSString *)userEmailSign
//{
//    [Setting setValue:userEmailSign settingKey:kUserEmailSignatureKey];
//}
//
//+ (void)resetAccount
//{
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults removeObjectForKey:kUserIdSettingKey];
//    [standardUserDefaults removeObjectForKey:kUserPasswordSettingKey];
//    [standardUserDefaults removeObjectForKey:kUserProfileSettingKey];
//    [standardUserDefaults removeObjectForKey:kUserEmailSignatureKey];
//    [standardUserDefaults synchronize];
//}

@end
