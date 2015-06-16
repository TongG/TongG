/*=============================================================================┐
|             _  _  _       _                                                  |  
|            (_)(_)(_)     | |                            _                    |██
|             _  _  _ _____| | ____ ___  ____  _____    _| |_ ___              |██
|            | || || | ___ | |/ ___) _ \|    \| ___ |  (_   _) _ \             |██
|            | || || | ____| ( (__| |_| | | | | ____|    | || |_| |            |██
|             \_____/|_____)\_)____)___/|_|_|_|_____)     \__)___/             |██
|                                                                              |██
|                 _______    _             _                 _                 |██
|                (_______)  (_)           | |               | |                |██
|                    _ _ _ _ _ ____   ___ | |  _ _____  ____| |                |██
|                   | | | | | |  _ \ / _ \| |_/ ) ___ |/ ___)_|                |██
|                   | | | | | | |_| | |_| |  _ (| ____| |    _                 |██
|                   |_|\___/|_|  __/ \___/|_| \_)_____)_|   |_|                |██
|                             |_|                                              |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Guo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#import "TWPTwitterUserProfileView.h"

@implementation TWPTwitterUserProfileView

@dynamic navigationBarController;

@synthesize hideButton;
@synthesize cuttingLineView;

@synthesize userAvatar;
@synthesize userDisplayNameField;
@synthesize userScreenNameField;

@synthesize tweetsCountButton;
@synthesize followersCountButton;
@synthesize followingCountButton;

@synthesize tweetToUserButton;
@synthesize sendADirectMessageButton;
@synthesize addOrRemoveFromListsButton;

@synthesize iDoNotLikeThisGuyButton;

@dynamic twitterUser;

#pragma mark Dynamic Accessors
- ( void ) setNavigationBarController: ( TWPNavigationBarController* )_NavigationBarController
    {
    self->_navigationBarController = _NavigationBarController;
    }

- ( TWPNavigationBarController* ) navigationBarController
    {
    return self->_navigationBarController;
    }

- ( void ) setTwitterUser: ( OTCTwitterUser* )_TwitterUser
    {
    self->_twitterUser = _TwitterUser;

    if ( self->_twitterUser )
        {
        [ self.userDisplayNameField setStringValue: self->_twitterUser.displayName ];
        [ self.userScreenNameField setStringValue: self->_twitterUser.screenName ];

        [ self.tweetToUserButton setTitle: [ NSString stringWithFormat: @"Tweet to %@", self->_twitterUser.screenName ] ];
        }
    }

- ( OTCTwitterUser* ) twitterUser
    {
    return self->_twitterUser;
    }

#pragma mark Custom Drawing
- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ [ NSColor whiteColor ] set ];
    NSRectFill( _DirtyRect );
    }

@end

/*=============================================================================┐
|                                                                              |
|                                        `-://++/:-`    ..                     |
|                    //.                :+++++++++++///+-                      |
|                    .++/-`            /++++++++++++++/:::`                    |
|                    `+++++/-`        -++++++++++++++++:.                      |
|                     -+++++++//:-.`` -+++++++++++++++/                        |
|                      ``./+++++++++++++++++++++++++++/                        |
|                   `++/++++++++++++++++++++++++++++++-                        |
|                    -++++++++++++++++++++++++++++++++`                        |
|                     `:+++++++++++++++++++++++++++++-                         |
|                      `.:/+++++++++++++++++++++++++-                          |
|                         :++++++++++++++++++++++++-                           |
|                           `.:++++++++++++++++++/.                            |
|                              ..-:++++++++++++/-                              |
|                             `../+++++++++++/.                                |
|                       `.:/+++++++++++++/:-`                                  |
|                          `--://+//::-.`                                      |
|                                                                              |
└=============================================================================*/