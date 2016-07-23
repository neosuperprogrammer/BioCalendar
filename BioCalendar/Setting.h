//
//  Setting.h
//  TMG_iPhone_GSC
//
//  Created by Sangwook Nam on 9/5/14.
//  Copyright (c) 2014 tionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Setting : NSObject


+ (NSString *)ipAddress;
+ (void)saveIpAddress:(NSString *)ipAddress;
+ (int)port;
+ (void)savePort:(int)port;

+ (NSTimeInterval)networkConnectionTimeout;
+ (void)saveNetworkConnectionTimeout:(NSTimeInterval)timeout;
+ (NSTimeInterval)networkReadTimeout;
+ (void)saveNetworkReadTimeout:(NSTimeInterval)timeout;

+ (NSString *)userId;
+ (void)saveUserId:(NSString *)userId;

+ (BOOL)userIdSaved;
+ (void)saveUserIdSave:(BOOL)save;

+ (NSString *)authKey;
+ (void)saveAuthKey:(NSString *)authKey;
+ (void)resetAuthKey;

+ (NSString *)companyCode;
+ (void)saveCompanyCode:(NSString *)companyCode;
+ (void)resetCompanyCode;

+ (NSString *)companyName;
+ (void)saveCompanyName:(NSString *)companyName;
+ (void)resetCompanyName;

+ (NSString *)deviceToken;
+ (void)saveDeviceToken:(NSString *)deviceToken;

+ (NSString *)email;
+ (void)saveEmail:(NSString *)email;

+ (NSString *)emailSignature;
+ (void)saveEmailSignature:(NSString *)emailSignature;

+ (BOOL)usePush;
+ (void)saveUsePush:(BOOL)usePush;

+ (NSString *)loginName;
+ (void)saveLoginName:(NSString *)loginName;

+ (BOOL)useOfflineContact;
+ (void)saveUseOfflineContact:(BOOL)useOfflineContact;

+ (NSDate *)lastestLoginTime;
+ (void)saveLatestLoginTime:(NSDate *)latestLoginTime;

+ (NSString *)noticeHtml;
+ (void)saveNoticeHtml:(NSString *)noticeHtml;
+ (void)resetNoticeHtml;

+ (NSDate *)notShowNoticeToday;
+ (void)saveNotShowNoticeToday:(NSDate *)notShowNoticeToday;
+ (void)resetNotShowNoticeToday;

+ (NSString *)noticeContentId;
+ (void)saveNoticeContentId:(NSString *)contentId;
+ (void)resetNoticeContentId;


+ (NSString *)languageCode;
+ (void)saveLanguageCode:(NSString *)languageCode;

+ (NSString *)mailAddress;
+ (void)saveMailAddress:(NSString *)address;

// 신규 메뉴관련 추가
+ (NSString *)DeptName;
+ (void)saveDeptName:(NSString *)deptName;

+ (NSString *)GradeName;
+ (void)saveGradeName:(NSString *)gradeName;

+ (NSString *)userLevelCode;
+ (void)saveUserLevelCode:(NSString *)userLevel;

+ (BOOL)useGlobalProfile;
+ (void)saveUseGlobalProfile:(BOOL)useGlobalProfile;

+ (BOOL)hasApprovalDelegate;
+ (void)saveHasApprovalDelegate:(BOOL)hasApprovalDelegate;

+ (NSString *)profileImageURL;
+ (void)saveProfileImageURL:(NSString *)url;

+ (NSMutableArray *)autoCompleteList;
+ (void)saveAutoCompleteList:(NSMutableArray *)value;

+ (void)adjustLanguageCode;

+ (void)setMailDetailViewExpand:(BOOL)expand;
+ (BOOL)isMailDetailViewExpand;
+ (void)setApprovalDetailViewExpand:(BOOL)expand;
+ (BOOL)isApprovalDetailViewExpand;
+ (void)setBoardDetailViewExpand:(BOOL)expand;
+ (BOOL)isBoardDetailViewExpand;

+ (BOOL)hasPermissionForApproval;
+ (BOOL)hasPermissionForSecurityMail;
+ (BOOL)hasPermissionForDocument;

//+ (NSString *)localPassword;
//+ (void)setLocalPassword:(NSString *)localPassword;
//
//+ (NSString *)phoneNumber;
//+ (void)setPhoneNumber:(NSString *)phoneNumber;
//
//+ (NSString *)screenLockTime;
//+ (void)setScreenLockTime:(NSString *)lockTime;
//
//+ (NSString *)lastLocalPasswordCheckDate;
//+ (void)setLastLocalPasswordCheckDate:(NSString *)lastLocalPasswordCheckDate;
//
//+ (NSString *)ipAddress;
//+ (void)setIpAddress:(NSString *)ipAddress;
//
//+ (int)port;
//+ (void)setPort:(int)port;
//
//+ (BOOL)usePush;
//+ (void)setUsePush:(BOOL)usePush;
//
//+ (NSString *)pushStartTime;
//+ (void)setPushStartTime:(NSString *)pushStartTime;
//+ (NSString *)pushEndTime;
//+ (void)setPushEndTime:(NSString *)pushEndTime;
//+ (void)setDeviceToken:(NSString *)deviceToken;
//
//+ (NSString *)accountId;
//+ (void)setAccountId:(NSString *)accountId;
//+ (NSString *)accountPassword;
//+ (void)setAccountPassword:(NSString *)accountPassword;
//+ (NSString *)userProfilePrefix;
//+ (void)setUserProfilePrefix:(NSString *)userProfilePrefix;
//+ (NSString *)userEmailSign;
//+ (void)setUserEmailSign:(NSString *)userEmailSign;
//
//+ (void)resetAccount;

@end
