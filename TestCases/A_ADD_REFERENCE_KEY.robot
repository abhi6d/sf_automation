*** Settings ***
Documentation   Sample TestCase For Automation FrameWork
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ../Resource/PageKeywords/SF_Login_Keyword.robot
Resource    ../Resource/PageKeywords/SF_UI_Keywords.robot


Resource    ../Resource/PageKeywords/Read_TestData_Keyword.robot
Library  ../Resource/TestData/Provision_Functions.py
Library  ../Resource/TestData/ReadDataFromExcel.py

Variables    ../Resource/PageObjects/PageObjects.yaml
Variables    ../Resource/PageObjects/TestData.yaml
Resource     ../Resource/PageKeywords/Common.robot

Library  OperatingSystem


Test Setup        Execute Suite Setup as User
Test Teardown     Execute Suite Teardown

*** Variables ***

${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
${SmartFern_CREDENTIAL}     ${TestData}[USER][SmartFern_user_2]
${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
${ISIPulsaDetailsPage}    ${wkd}[ISIPulsaDetailsPage]
${BeliPacketDetailsPage}    ${wkd}[BeliPacketDetailsPage]
${ADD_REFERENCE_KEY}  ${wkd}[ADD_REFERENCE_KEY]

*** Test Cases ***
TEST CASE 001
    [Documentation]    Validate Isi pulsa and beli paket
    Login to SMARTFERN UI  ${SmartFern_CREDENTIAL}[username]  ${SmartFern_CREDENTIAL}[password]

    #${row}=  Read Number of Rows  ${SMARTFREN_TESTDATA}  SMARTFREN_ISI_PULSA
    Sleep  10s
    Click Item     ${ADD_REFERENCE_KEY}[Apps]
    #Click Item     ${ADD_REFERENCE_KEY}[DMS]
    Sleep  10s
    #Verify elements is visible and displayed  //span[text()='Settings']
    #${present}=  Run Keyword And Return Status    Element Should Be Visible   //span[text()='Settings']
    #Run Keyword If    ${present}    Click Item  //span[text()='Settings']
    #Click Item  (//a[contains(@class,'parentLink')])[4]
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      (//a[contains(@class,'parentLink')])[4]
    Click Item  //span[text()='Settings']
    Click Item  //a[normalize-space()='Configure Reference Key']
    Click Item  //div[@class=' css-ackcql']
    Click Item  //button[@class='btn drop-down-button btn-sm btn-block cursor']
    Set Input      //input[@id='dropDownValue__id']  Test_1
    Click Item  //div[normalize-space()='Create']

    Sleep  10s