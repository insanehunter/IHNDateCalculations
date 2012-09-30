/*
 * (c) Sergei Cherepanov, 2012
 */
#import <SenTestingKit/SenTestingKit.h>
#import "NSDate+IHNDateCalculations.h"

@interface IHNDateCalculationsTests : SenTestCase
{
    NSDateFormatter *dateFormatter;
    NSDate *now, *arbitraryFutureDate, *arbitraryPastDate;
}
@end

#pragma mark -
@implementation IHNDateCalculationsTests
- (BOOL) date:(NSDate *)date1 and:(NSDate *)date2 differByYears:(NSInteger)years months:(NSInteger)months
         days:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                                                    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                          fromDate:date1 toDate:date2 options:0];
    STAssertNotNil(comps, @"Date components cannot be retrieved.");
    return comps.year == years && comps.month == months && comps.day == days &&
            comps.hour == hours && comps.minute == minutes && comps.second == seconds;
}

- (void) setUp
{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:(7 * 60 * 60)]];
    
    now = [NSDate date];
    arbitraryFutureDate = [dateFormatter dateFromString:@"2031-11-20T21:12:59Z"];
    STAssertNotNil(arbitraryFutureDate, @"Date can't be initialized from string");
    arbitraryPastDate = [dateFormatter dateFromString:@"2011-06-23T11:50:23Z"];
    STAssertNotNil(arbitraryPastDate, @"Date can't be initialized from string");
    
    // Checking if date comparison helpers actually work.
    STAssertTrue([self date:now and:now differByYears:0 months:0
                       days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:1 months:0
                        days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:1
                        days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:1 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:0 hours:1 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:0 hours:0 minutes:1 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:0 hours:0 minutes:0 seconds:1], @"");
    STAssertTrue([self date:arbitraryPastDate and:arbitraryFutureDate differByYears:20 months:4
                       days:28 hours:9 minutes:22 seconds:36], @"");
    STAssertTrue([self date:arbitraryFutureDate and:arbitraryPastDate differByYears:-20 months:-4
                       days:-27 hours:-9 minutes:-22 seconds:-36], @"");
}

- (void) testComparison
{
    STAssertTrue([now isEarlierThan:arbitraryFutureDate], @"");
    STAssertTrue([arbitraryPastDate isEarlierThan:now], @"");
    STAssertTrue([arbitraryPastDate isEarlierThan:arbitraryFutureDate], @"");
    STAssertTrue([now isEqualOrEarlierThan:arbitraryFutureDate], @"");
    STAssertTrue([arbitraryPastDate isEqualOrEarlierThan:now], @"");
    STAssertTrue([arbitraryPastDate isEqualOrEarlierThan:arbitraryFutureDate], @"");
    STAssertTrue([now isEqualOrEarlierThan:now], @"");
    STAssertFalse([now isEarlierThan:now], @"");
    STAssertFalse([arbitraryFutureDate isEarlierThan:now], @"");
    
    STAssertTrue([arbitraryFutureDate isLaterThan:now], @"");
    STAssertTrue([now isLaterThan:arbitraryPastDate], @"");
    STAssertTrue([arbitraryFutureDate isLaterThan:arbitraryPastDate], @"");
    STAssertTrue([arbitraryFutureDate isEqualOrLaterThan:now], @"");
    STAssertTrue([now isEqualOrLaterThan:arbitraryPastDate], @"");
    STAssertTrue([arbitraryFutureDate isEqualOrLaterThan:arbitraryPastDate], @"");
    STAssertTrue([now isEqualOrLaterThan:now], @"");
    STAssertFalse([now isLaterThan:now], @"");
    STAssertFalse([arbitraryPastDate isLaterThan:now], @"");
}

- (void) testMothsAgo
{
    NSDate *monthsAgo = [arbitraryPastDate monthsAgo:2];
    STAssertTrue([self date:monthsAgo and:arbitraryPastDate differByYears:0 months:2
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthsAgo = [now monthsAgo:8];
    STAssertTrue([self date:monthsAgo and:now differByYears:0 months:8
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthsAgo = [arbitraryFutureDate monthsAgo:0];
    STAssertTrue([self date:monthsAgo and:arbitraryFutureDate differByYears:0 months:0
                       days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertThrows([now monthsAgo:-1], @"");
}

- (void) testMonthAgo
{
    NSDate *monthAgo = [arbitraryPastDate monthAgo];
    STAssertTrue([self date:monthAgo and:arbitraryPastDate differByYears:0 months:1
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthAgo = [now monthAgo];
    STAssertTrue([self date:monthAgo and:now differByYears:0 months:1
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthAgo = [arbitraryFutureDate monthAgo];
    STAssertTrue([self date:monthAgo and:arbitraryFutureDate differByYears:0 months:1
                       days:0 hours:0 minutes:0 seconds:0], @"");
}

- (void) testDaysAgo
{
    NSDate *daysAgo = [arbitraryPastDate daysAgo:30];
    STAssertTrue([self date:daysAgo and:arbitraryPastDate differByYears:0 months:0
                       days:30 hours:0 minutes:0 seconds:0], @"");
    daysAgo = [now daysAgo:8];
    STAssertTrue([self date:daysAgo and:now differByYears:0 months:0
                       days:8 hours:0 minutes:0 seconds:0], @"");
    daysAgo = [arbitraryFutureDate daysAgo:0];
    STAssertTrue([self date:daysAgo and:arbitraryFutureDate differByYears:0 months:0
                       days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertThrows([now daysAgo:-1], @"");
}

- (void) testDayAgo
{
    NSDate *dayAgo = [arbitraryPastDate dayAgo];
    STAssertTrue([self date:dayAgo and:arbitraryPastDate differByYears:0 months:0
                       days:1 hours:0 minutes:0 seconds:0], @"");
    dayAgo = [now dayAgo];
    STAssertTrue([self date:dayAgo and:now differByYears:0 months:0
                       days:1 hours:0 minutes:0 seconds:0], @"");
    dayAgo = [arbitraryFutureDate dayAgo];
    STAssertTrue([self date:dayAgo and:arbitraryFutureDate differByYears:0 months:0
                       days:1 hours:0 minutes:0 seconds:0], @"");
}

- (void) testMonthsAfter
{
    NSDate *monthsAfter = [arbitraryPastDate monthsAfter:2];
    STAssertTrue([self date:monthsAfter and:arbitraryPastDate differByYears:0 months:-2
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthsAfter = [now monthsAfter:8];
    STAssertTrue([self date:monthsAfter and:now differByYears:0 months:-8
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthsAfter = [arbitraryFutureDate monthsAfter:0];
    STAssertTrue([self date:monthsAfter and:arbitraryFutureDate differByYears:0 months:0
                       days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertThrows([now monthsAfter:-1], @"");
}

- (void) testMonthAfter
{
    NSDate *monthAfter = [arbitraryPastDate monthAfter];
    STAssertTrue([self date:monthAfter and:arbitraryPastDate differByYears:0 months:-1
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthAfter = [now monthAfter];
    STAssertTrue([self date:monthAfter and:now differByYears:0 months:-1
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthAfter = [arbitraryFutureDate monthAfter];
    STAssertTrue([self date:monthAfter and:arbitraryFutureDate differByYears:0 months:-1
                       days:0 hours:0 minutes:0 seconds:0], @"");
}

- (void) testDaysAfter
{
    NSDate *daysAfter = [arbitraryPastDate daysAfter:29];
    STAssertTrue([self date:daysAfter and:arbitraryPastDate differByYears:0 months:0
                       days:-29 hours:0 minutes:0 seconds:0], @"");
    daysAfter = [now daysAfter:8];
    STAssertTrue([self date:daysAfter and:now differByYears:0 months:0
                       days:-8 hours:0 minutes:0 seconds:0], @"");
    daysAfter = [arbitraryFutureDate daysAfter:0];
    STAssertTrue([self date:daysAfter and:arbitraryFutureDate differByYears:0 months:0
                       days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertThrows([now daysAfter:-1], @"");
}

- (void) testDayAfter
{
    NSDate *dayAfter = [arbitraryPastDate dayAfter];
    STAssertTrue([self date:dayAfter and:arbitraryPastDate differByYears:0 months:0
                       days:-1 hours:0 minutes:0 seconds:0], @"");
    dayAfter = [now dayAfter];
    STAssertTrue([self date:dayAfter and:now differByYears:0 months:0
                       days:-1 hours:0 minutes:0 seconds:0], @"");
    dayAfter = [arbitraryFutureDate dayAfter];
    STAssertTrue([self date:dayAfter and:arbitraryFutureDate differByYears:0 months:0
                       days:-1 hours:0 minutes:0 seconds:0], @"");
}
@end
