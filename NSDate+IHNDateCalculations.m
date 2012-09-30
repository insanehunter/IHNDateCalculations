/*
 * (c) Sergei Cherepanov, 2012
 */
#import "NSDate+IHNDateCalculations.h"

#if !__has_feature(objc_arc)
    #error NSDate+IHNDateCalculations requires ARC support.
#endif

@implementation NSDate (IHNDateCalculations)
- (NSDate *) monthsAgo:(NSInteger)months
{
    NSParameterAssert(months >= 0);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:-months];
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *) monthAgo
{
    return [self monthsAgo:1];
}
@end
