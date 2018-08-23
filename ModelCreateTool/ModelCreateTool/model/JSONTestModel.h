
#import <Foundation/Foundation.h>

@interface LoanlistModel : NSObject
@property (strong,nonatomic) NSString *applyStep;
@property (strong,nonatomic) NSString *rentStatus;
@property (strong,nonatomic) NSString *verificateStatus;
@property (strong,nonatomic) NSString *productType;
@property (strong,nonatomic) NSString *marginPayStatus;
@property (strong,nonatomic) NSString *intervalDays;
@property (strong,nonatomic) NSString *currentTerm;
@property (strong,nonatomic) NSString *isConfirm;
@property (strong,nonatomic) NSString *vehicleCode;
@property (strong,nonatomic) NSString *currentPayMon;
@property (strong,nonatomic) NSString *contractNo;
@property (strong,nonatomic) NSString *reloanDate;
@property (strong,nonatomic) NSString *marginStatus;
@property (strong,nonatomic) NSString *verificateCode;
@property (strong,nonatomic) NSString *loanStatus;
@property (strong,nonatomic) NSString *loanNo;
@property (strong,nonatomic) NSString *loanSource;
@property (strong,nonatomic) NSString *marginStep;
@property (strong,nonatomic) NSString *restAmount;
@property (strong,nonatomic) NSString *loanAmount;
@property (strong,nonatomic) NSString *loanDate;
@property (strong,nonatomic) NSString *marginPayTime;
@property (strong,nonatomic) NSString *restTerm;
@property (strong,nonatomic) NSString *vehicleDetail;
@end

@interface DataModel : NSObject
@property (strong,nonatomic) NSNumber *counts;
@property (strong,nonatomic) NSArray <LoanlistModel *> *loanList;
@end

@interface JSONTestModel : NSObject
@property (strong,nonatomic) NSString *retmsg;
@property (strong,nonatomic) NSNumber *retcode;
@property (strong,nonatomic) DataModel *data;
@end


