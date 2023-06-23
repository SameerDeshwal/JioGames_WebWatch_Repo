*** Settings ***
Library                             SeleniumLibrary
Library                             ExcelLibrary
Library                             RequestsLibrary
Library                             String
Library                             Collections
Library                             Dialogs
Resource                            common.robot
Variables                           Common_Variables.yaml
*** Keywords ***
Banner Content Verification
    [Arguments]                     ${Txt_locator}      ${txt}      ${Img_locator}  ${Btn_locator}   ${Scn_Name}
    Wait For And Verify Content     ${Txt_locator}      ${txt}
    #Image Verification              ${Img_locator}
    Wait For And Verify Element     ${Img_locator}
    ${Buttons}=      Get WebElements     ${Btn_locator}
    FOR  ${Button}  IN  @{Buttons}
        Mouse Over                      ${Button}
        Page Should Contain Button      ${Button}
    END    
    Take Page Screenshot                 ${Scn_Name}
    Log To Console                  ${Scn_Name} Section Content Verified

Banner Redirection
    [Arguments]     ${locator_id}   ${Sc_Name}
    ${visiblity}=   Run Keyword And Return Status   Wait Until Element Is Visible       xpath=//ul[@class='slick-dots']
    ${RURL}=    Get Location
    IF  ${visiblity} == True
        ${VB}  Set Variable   0
        WHILE  ${VB} < 3
            Wait For And Click Element      xpath=//li[@id='${locator_id}${VB}']
            Wait For And Click Element      xpath=//div[@class="j-fullwidth-banner slick-slide slick-current slick-active"][@aria-describedby="${locator_id}${VB}"]//button[contains(@class,'redirectButton')]
            Sleep  1s
            Take Page Screenshot                 ${Sc_Name}_BannerRedirection_${VB}
            Log To Console                  ${Sc_Name}_Banner_${VB} Redirection Successful
            Go To                           ${RURL}
            ${VB}=   Evaluate     ${VB} + 1
        END
    ELSE
        Wait For And Click Element      ${locator_id}
        Take Page Screenshot                 ${Sc_Name}_BannerRedirection
        Log To Console                  ${Sc_Name}_Banner_Redirection Successful
        Go Back
    END

Toast Capture and Data Validation
    [Arguments]    ${locator}    ${SC_name}    ${Title}
    #Sleep    1s
    Wait For And Verify Content        ${locator}              ${Title}
    Take Page Screenshot             ${SC_name}-Page-Screenshot
    Log To Console                   ${Title} 

Verify UI of Video tile           
    ${Videos}=    Get WebElements              xpath=//div[@class="max-w-[250px] min-w-[250px] group hover:scale-[1.2] hover:z-50 transition duration-200 ease-out rounded-lg relative cursor-pointer"]
    ${Count} =     Get Length    ${Videos}   
    Log To Console    ${Count}     
    
    #For Loop to verify videos 
    FOR     ${i}    IN RANGE    1    ${Count}
        #Thumbnail    
        Wait For And Verify Element            xpath=(//div[@class='w-full h-full max-h-[140px] relative group-hover:shadow-3xl'])[${i}]

        #Duration
        Wait For And Verify Element            xpath=(//div[@class='absolute bottom-3 text-[10px] w-max right-2.5 text-right bg-surface text-onSurface px-2 py-1 rounded-lg font-JioTypeBold'])[${i}]

        #Views
        Wait For And Verify Element            xpath=(//span[@class='text-onSurface text-[10px] pl-1 font-JioTypeBold'])[${i}]

        #Video title
        Wait For And Verify Element            xpath=(//div[@class='text-onPrimary font-JioTypeBold text-sm line-clamp-1'])[${i}]

        #Channel name
        Wait For And Verify Element            xpath=(//div[@class='text-onPrimary font-JioTypeLight text-sm line-clamp-2'])[${i}]

        #Video tag
        Wait For And Verify Element            xpath=(//div[@class='text-onPrimary font-JioTypeLight text-sm '])[${i}]

        #channel profile picture
        Wait For And Verify Element            xpath=(//img[@class='rounded-full w-full h-full shrink-0'])[${i}]

        #Category
        Wait For And Verify Element            xpath=(//div[@class='border border-borderPrimary text-xs w-max px-4 py-1.5 mb-[16px] rounded-full font-JioTypeLight text-onPrimary'])[${i}]

        #kebab menu
        Wait For And Verify Element            xpath=(//div[@class='flex min-w-[10px] items-end justify-end w-full'])[${i}]
    END