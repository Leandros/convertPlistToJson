#import <Foundation/Foundation.h>
#import "JSONKit.h"

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s FILE_PLIST FILE_JSON\n", argv[0]);
        exit(5);
    }

    NSString *plistFileNameString = [NSString stringWithUTF8String:argv[1]];
    NSString *jsonFileNameString = [NSString stringWithUTF8String:argv[2]];

    NSError *error = NULL;

    NSData *plistFileData = [NSData dataWithContentsOfFile:plistFileNameString options:0UL error:&error];
    if (plistFileData == NULL) {
        NSLog(@"Unable to read plist file.  Error: %@, info: %@", error, [error userInfo]);
        exit(1);
    }

    id plist = [NSPropertyListSerialization propertyListWithData:plistFileData options:NSPropertyListImmutable format:NULL error:&error];
    if (plist == NULL) {
        NSLog(@"Unable to deserialize property list.  Error: %@, info: %@", error, [error userInfo]);
        exit(1);
    }

    NSData *jsonData = [plist JSONDataWithOptions:JKSerializeOptionPretty error:&error];
    if (jsonData == NULL) {
        NSLog(@"Unable to serialize plist to JSON.  Error: %@, info: %@", error, [error userInfo]);
        exit(1);
    }

    if (![jsonData writeToFile:jsonFileNameString options:NSDataWritingAtomic error:&error]) {
        NSLog(@"Unable to write JSON to file.  Error: %@, info: %@", error, [error userInfo]);
        exit(1);
    }

    return (0);
}
