#import "MEGAUser.h"

@interface MEGAUser (MNZCategory)

/**
 *  The concatenation of MEGA user firstname and lastname.
 * 
 * @note: If the contact has not firstname nor lastname or both are empty, this property is nil.
 *
 */
@property (nonatomic, readonly) NSString *mnz_fullName;

@end
