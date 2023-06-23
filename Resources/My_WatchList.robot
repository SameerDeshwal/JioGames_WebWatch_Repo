*** Settings ***
Library                      SeleniumLibrary
Resource                     ../Resources/My_Watchlist_PO/RedirectionToMyWatchList.robot
Resource                     ../Resources/My_Watchlist_PO/My_WatchList_PO.robot

*** Keywords ***

Verify Redirection, UI & functionality of MyWatchlist Page
    Visit Jio Games Web Watch and Login 
    Verification of MyWatchlist Page Redirection, UI & functionality
    
Verify valid & invalid URL Redirection
    Visit Jio Games Web Watch and Login
    User lands on "My Watchlist" page on clicking the page "URL"

