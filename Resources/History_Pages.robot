*** Settings ***
Library                      SeleniumLibrary
Resource                     ../Resources/History_PO/RedirectionToHistory.robot
Resource                     ../Resources/History_PO/History_PO.robot

*** Keywords ***

Verifying video is playable 
    Visit Jio Games Web Watch and Login
    Landing on History Page
    check videos are playable and user can pause and close video

Add to Watch Later function
    Visit Jio Games Web Watch and Login
    Landing on History Page
    Add to watch later

Remove from watchlist function
    Visit Jio Games Web Watch and Login
    Landing on History Page
    Remove from watchlist 

Invalid URL verification
    Visit Jio Games Web Watch and Login
    Landing on History Page
    Confirm if the user is able to clear history using the "Clear history" button.

Profile photo 
    Visit Jio Games Web Watch and Login
    History Page Redirection & Verifiation
        

MyWatchlist Page UI and Redirection
    Visit Jio Games Web Watch and Login
    Landing on History Page
    History Page Redirection & Verifiation
    