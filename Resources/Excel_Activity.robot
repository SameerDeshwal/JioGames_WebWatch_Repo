*** Settings ***
Library                             SeleniumLibrary
Library                             ExcelLibrary
Library                             String

*** Keywords ***
#History
Reading Data of Sidebar Buttons from Excel
        [Arguments]                  ${ROW}
        ${menus}=                   Read Excel Cell          row_num=${ROW}     col_num=1   sheet_name=Collapse menu
        ${menus_url}=               Read Excel Cell          row_num=${ROW}     col_num=2   sheet_name=Collapse menu
        
        Set Global Variable          ${menus}                                ${menus}
        Set Global Variable          ${menus_url}                            ${menus_url}

        Set Screenshot Directory     ./Results/Screenshot