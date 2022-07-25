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
    Click Item     ${ADD_REFERENCE_KEY}[Apps]

    ${present}=  Run Keyword And Return Status    Element Should Be Visible   ${ADD_REFERENCE_KEY}[DMS]
    Run Keyword If    ${present}    Click Item  ${ADD_REFERENCE_KEY}[DMS]

    Click Item  //span[text()='Settings']
    Click Item  //a[normalize-space()='Configure Reference Key']
    Click Item  //div[@class=' css-ackcql']
    Click Item  //button[@class='btn drop-down-button btn-sm btn-block cursor']
    Set Input      //input[@id='dropDownValue__id']  Test_11
    Click Item  //div[normalize-space()='Create']
    Sleep  5s
