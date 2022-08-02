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

    Click Item  //span[text()='Sales Structure']
    Click Item  //a[normalize-space()='Sales Territory']
    Click Item  //div[normalize-space()='Traditional (Trade Telco)']/following-sibling::div//div[@class='dropdown']
    Click Item  (//button[contains(@role,'menuitem')][normalize-space()='Create'])[1]
    Set Input  //input[@id='greaterRegionCode__id']  7966
    Set Input  //input[@id='locationName__id']  est_7966
    Set Input  //input[@id='effectiveDate__id']  2022-07-29
    Click Item  //div[contains(text(),' Save')]
    Click Item  (//i[contains(@class,'fa fa-ellipsis-h')])[7]
    Sleep  10s