*** Settings ***
Library            SeleniumLibrary
Resource           ../../Resources/My_WatchList.robot

Test Setup                      Begin Web Test
Test Teardown                   End Web Test
*** Test Cases ***

Confirm Redirection, UI & functionality of MyWatchlist Page
    [Documentation]    My_Watchlist [Merged with 110929,110935,110937]   [110936 is Out Of Scope]
    [Tags]    ${TC-01_MyWatchlist}    TC-01_MyWatchlist
    Verify Redirection, UI & functionality of MyWatchlist Page

Confirm valid & invalid URL Redirection
    [Documentation]    My_Watchlist [Merged 110933,110949]
    [Tags]    ${TC-02_MyWatchlist}    TC-02_MyWatchlist
    Verify valid & invalid URL Redirection