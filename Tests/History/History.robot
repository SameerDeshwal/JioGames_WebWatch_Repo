*** Settings ***
Library            SeleniumLibrary
Resource           ../../Resources/History_Pages.robot

Suite Setup                      Begin Web Test
Suite Teardown                   End Web Test
*** Test Cases ***



Test Case 110905: Confirm that user is able to select "History" option from the collapse menu.
    [Documentation]    History/URL  [Merged with 110906,110907,110909,110910,110914,110918,110919,110920]
    [Tags]    TC-110905
    MyWatchlist Page UI and Redirection

Test Case 110915: Validate the "Add to Watch later" option.
    [Documentation]     History
    [Tags]    TC-110915
    Add to Watch Later function

Test Case 110916: Validate the "Remove from Watch list" option.
    [Documentation]     History
    [Tags]    TC-110916
    Profile photo

Test Case 110926: Confirm if "404 error" appears if URL has extra letters or is incomplete
    [Documentation]    History/URL  [Merged with 110908,110911,110912,110913]
    [Tags]    TC-110926
    Invalid URL verification

