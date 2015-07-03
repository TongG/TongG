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

#import "TWPBrain.h"
#import "TWPDirectMessagesPreviewViewController.h"
#import "TWPDirectMessageSession.h"
#import "TWPLoginUsersManager.h"
#import "TWPDirectMessagePreviewCellView.h"
#import "TWPUserAvatarWell.h"

// Private Interfaces
@interface TWPDirectMessagesPreviewViewController ()
@end // Private Interfaces

// TWPDirectMessagesPreviewViewController class
@implementation TWPDirectMessagesPreviewViewController

@synthesize DMPreviewTableView;

#pragma mark Initialization
- ( instancetype ) initWithCoder: ( NSCoder* )_Coder
    {
    if ( self = [ super initWithNibName: @"TWPDirectMessagesPreviewView" bundle: [ NSBundle mainBundle ] ] )
        {
        self->_directMessageSessions = [ NSMutableArray array ];
        [ self setTotemContent: [ NSImage imageNamed: TWPArtworkMessagesTabGray ] ];
        }

    return self;
    }

- ( void ) viewDidLoad
    {
    [ super viewDidLoad ];
    self->_directMessageSessions = [ NSMutableArray arrayWithArray: [ [ TWPDirectMessagesCoordinator defaultCenter ] allDirectMessageSessions ] ];
    [ [ TWPDirectMessagesCoordinator defaultCenter ] registerObserver: self otherSideUser: nil ];
    }

#pragma mark Conforms to <NSTableViewDataSource>
- ( NSInteger ) numberOfRowsInTableView: ( NSTableView* )_TableView
    {
    return self->_directMessageSessions.count;
    }

- ( id )            tableView: ( NSTableView* )_TableView
    objectValueForTableColumn: ( NSTableColumn* )_TableColumn
                          row: ( NSInteger )_Row
    {
    id result = [ self->_directMessageSessions objectAtIndex: _Row ];
    return result;
    }

#pragma mark Conforms to <NSTableViewDelegate>
- ( NSView* ) tableView: ( NSTableView* )_TableView
     viewForTableColumn: ( NSTableColumn* )_TableColumn
                    row: ( NSInteger )_Row
    {
    TWPDirectMessagePreviewCellView* previewCellView =
        ( TWPDirectMessagePreviewCellView* )[ _TableView makeViewWithIdentifier: _TableColumn.identifier owner: self ];

    TWPDirectMessageSession* DMSession = ( TWPDirectMessageSession* )( self->_directMessageSessions[ _Row ] );
    previewCellView.session = DMSession;

    return previewCellView;
    }

- ( BOOL ) tableView: ( NSTableView* )_TableView
     shouldSelectRow: ( NSInteger )_RowIndex
    {
    return NO;
    }

- ( void ) tableViewSelectionDidChange: ( NSNotification* )_Notif
    {
    NSLog( @"%@", _Notif );
    }

#pragma mark Conforms to <TWPDirectMessagesCoordinatorObserver>
- ( void )       coordinator: ( TWPDirectMessagesCoordinator* )_Coordinator
    didAddNewSessionWithUser: ( OTCTwitterUser* )_OtherSideUser
    {
#if DEBUG
    NSLog( @"🌍" );
#endif
    TWPDirectMessageSession* newSession = [ TWPDirectMessageSession sessionWithOtherSideUser: _OtherSideUser ];

    if ( newSession )
        {
        [ self->_directMessageSessions addObject: newSession ];
        [ self.DMPreviewTableView reloadData ];
        }
    }

- ( void )       coordinator: ( TWPDirectMessagesCoordinator* )_Coordinator
    didUpdateSessionWithUser: ( OTCTwitterUser* )_OtherSideUser
    {
#if DEBUG
    NSLog( @"🌞" );
#endif
    for ( TWPDirectMessageSession* _Session in self->_directMessageSessions )
        {
        if ( [ _Session.otherSideUser isEqualToUser: _OtherSideUser ] )
            {
            [ _Session reloadMessages ];
            [ self.DMPreviewTableView reloadData ];
            break;
            }
        }
    }

@end // TWPDirectMessagesPreviewViewController class

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