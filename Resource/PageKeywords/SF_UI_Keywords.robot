*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String
Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ../../Resource/PageKeywords/Common.robot
Library  ../TestData/ReadDataFromExcel.py

Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String
Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ./Common.robot


*** Variables ***
${URL}      ${TestData}[URL]
${Broswer}  ${TestData}[Browser]
${Environment}      ${TestData}[Environment]
#${OrderSearch}      ${CRMPage}[OrderSearch]
#${LoginPage}      ${CRMPage}[LoginPage]
${TimeOut}      60s
${Start}        1s

${URL}      ${TestData}[URL]
${Broswer}  ${TestData}[Browser]
${Environment}      ${TestData}[Environment]
#${OrderSearch}      ${CRMPage}[OrderSearch]
${TimeOut}      120s
${Start}        1s
${Orderid}=  960908078870589440


#############################################################

${CRM_TestData}     ${TestData}[CRM_TestData]
${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
#${WKD_CRM_TESTDATA}     ${TestData}[WKD_CRM_TESTDATA]
${SmartFern_CREDENTIAL}     ${TestData}[USER][SmartFern_user]
${ISIPulsaDetailsPage}    ${wkd}[ISIPulsaDetailsPage]
${BeliPacketDetailsPage}    ${wkd}[BeliPacketDetailsPage]
#${CRM_UI}  ${wkd}[SSOPage][crm]
#${ProfileDetailsPage}  ${CRMPage}[ProfileDetailPage]
#${AccoutDetailPage}  ${CRMPage}[AccoutDetailPage]
#${ServiceDetailsPage}  ${CRMPage}[ServiceDetailsPage]
#${HomePage}  ${CRMPage}[HomePage]        # Importing Home page Components
${SCREENSHOT_LOC}  ${TestData}[SCREENSHOT_LOC]
*** Keywords ***


#Manage tab
#    [Arguments]     ${Managetab}
#    #Verify elements is visible and displayed  ${Managetab}
#    wait until element is visible    ${Managetab}
#    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${Managetab}

#Refresh tab
#    [Arguments]     ${Refreshtab}
#    wait until element is visible    ${Refreshtab}
#    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${Refreshtab}


Validate Value
    [Arguments]     ${value}  ${locator}
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     wait until page contains element    ${locator}



Go Back to Home Page
    [Documentation]    To Navigate to Home screen of CRM UI
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element   ${HomePage}[HomeButton]

Handle PopUp
    [Arguments]     ${locator}  ${Expectedvalue}
    Verify elements is visible and displayed  ${locator}
    ${String}=  get text     ${locator}
    Log To Console  ------------------------
    Log To Console  ${String}
    Log To Console  ------------------------
    Should be equal  ${String}   ${Expectedvalue}

Set Slider
    [Arguments]     ${label}  ${value}
    #${String}=  get text     ${locator}
    #Log To Console  ${String}
    ${Is_Checkbox_Selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    //label[text()='${label}']/following-sibling::div/label//span/input[@type='checkbox']
    #Run Keyword If  '${Is_Checkbox_Selected}' != 'False'  Log To Console  NANACONDITION

    #Click Item  ${locator}

    ${passed}=    Run Keyword If  '${Is_Checkbox_Selected}' == 'False'  Set Variable    NO
    ...  ELSE IF  '${Is_Checkbox_Selected}' == 'True'  Set Variable    YES
    ...  ELSE  Log To Console  SLIDER STATUS SHOULD BE BINARY[True/False]

    Log To Console  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    Log To Console  ${passed}
    Log To Console  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

    Run Keyword If  '${value}' != '${passed}'  Click Item  //label[text()='${label}']/following-sibling::div/label//div
    ...  ELSE IF  '${value}' == 'nan'  Log To Console  Blank
    ...  ELSE  Log To Console  SLIDER STATUS SHOULD BE BINARY[YES/NO]

###############################################################################################################\


ISI_Pulsa
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${SMARTFREN_TESTDATA}  SMARTFREN_ISI_PULSA   ${caseID}  ${dataID}
    ${MDN_NUMBER}=  getData  ${data}  MDN_Number
    ${RP_VALUE}=  getData  ${data}  RP_Value
    ${PAYMENT_TYPE}=  getData  ${data}  Payment_Type
    ${PIN_NUMBER_DIGIT1}=  getData  ${data}  PIN_NUMBER_Digit1
    ${PIN_NUMBER_DIGIT2}=  getData  ${data}  PIN_NUMBER_Digit2
    ${PIN_NUMBER_DIGIT3}=  getData  ${data}  PIN_NUMBER_Digit3
    ${PIN_NUMBER_DIGIT4}=  getData  ${data}  PIN_NUMBER_Digit4
    ${PIN_NUMBER_DIGIT5}=  getData  ${data}  PIN_NUMBER_Digit5
    ${PIN_NUMBER_DIGIT6}=  getData  ${data}  PIN_NUMBER_Digit6




    Click Item     ${ISIPulsaDetailsPage}[Apps]

    TakePic  App.png
    Click Item     ${ISIPulsaDetailsPage}[POSApp]

    TakePic  Pos.png
    Click Item     ${ISIPulsaDetailsPage}[ISIPulsa]

    TakePic  ISI.png
    Set Input      ${ISIPulsaDetailsPage}[InputMDN]  ${MDN_NUMBER}

    TakePic  MDN.png
    Click Item     ${ISIPulsaDetailsPage}[InputMDNProceedButton]

    Set Input      ${ISIPulsaDetailsPage}[InputRPValue]  ${RP_VALUE}

    Click Item     ${ISIPulsaDetailsPage}[RPValueAddButton]

    Set Dropdown3  ${ISIPulsaDetailsPage}[PaymentTypeDropdown]  ${PAYMENT_TYPE}

    Click Item     ${ISIPulsaDetailsPage}[FinalProccedButton]
    Set Input      ${ISIPulsaDetailsPage}[PINDigit1]   ${PIN_NUMBER_DIGIT1}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit2]   ${PIN_NUMBER_DIGIT2}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit3]   ${PIN_NUMBER_DIGIT3}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit4]   ${PIN_NUMBER_DIGIT4}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit5]   ${PIN_NUMBER_DIGIT5}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit6]   ${PIN_NUMBER_DIGIT6}
    Click Item     ${ISIPulsaDetailsPage}[ConfirmButton]

    Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
    capture page screenshot  ${SCREENSHOT_LOC}/Img_1.png
    ${TranscationStatus}=  get text    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
    log to console   ${TranscationStatus}
    Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationId]
    capture page screenshot  ${SCREENSHOT_LOC}/Img_2.png
    ${Transcationid}=  get text    ${ISIPulsaDetailsPage}[TranscationId]
    log to console   ${Transcationid}
    capture page screenshot  ${SCREENSHOT_LOC}/Img_3.png
    Click Item     ${ISIPulsaDetailsPage}[TranscationOk]
    capture page screenshot  ${SCREENSHOT_LOC}/Img_4.png




Beli Paket
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${SMARTFREN_TESTDATA}  SMARTFREN_BELI_PAKET   ${caseID}  ${dataID}
    ${MDN_NUMBER}=  getData  ${data}  MDN_Number
    ${PACKAGE}=  getData  ${data}  Package
    ${RP_VALUE}=  getData  ${data}  RP_Value
    ${PAYMENT_TYPE}=  getData  ${data}  Payment_Type
    ${PIN_NUMBER_DIGIT1}=  getData  ${data}  PIN_NUMBER_Digit1
    ${PIN_NUMBER_DIGIT2}=  getData  ${data}  PIN_NUMBER_Digit2
    ${PIN_NUMBER_DIGIT3}=  getData  ${data}  PIN_NUMBER_Digit3
    ${PIN_NUMBER_DIGIT4}=  getData  ${data}  PIN_NUMBER_Digit4
    ${PIN_NUMBER_DIGIT5}=  getData  ${data}  PIN_NUMBER_Digit5
    ${PIN_NUMBER_DIGIT6}=  getData  ${data}  PIN_NUMBER_Digit6

    Click Item     ${BeliPacketDetailsPage}[Apps]
    Sleep  3s
    Click Item     ${BeliPacketDetailsPage}[POSApp]
    Sleep  5s
    Click Item     ${BeliPacketDetailsPage}[BeliPaket]
    Sleep  2s
    Set Input      ${BeliPacketDetailsPage}[InputMDN]  ${MDN_NUMBER}
    Sleep  2s
    Click Item     ${BeliPacketDetailsPage}[InputMDNProceedButton]
    Sleep  5s
    Set Input      ${BeliPacketDetailsPage}[SearchPackage]    ${PACKAGE}
    Sleep  5s
    Click Item     (//div[contains(text(),'${RP_Value}')])[1]
    Sleep  4s
    Set Dropdown3  ${BeliPacketDetailsPage}[PaymentTypeDropdown]  ${PAYMENT_TYPE}
    Sleep  3s
    Click Item     ${BeliPacketDetailsPage}[FinalProccedButton]
    Set Input      ${ISIPulsaDetailsPage}[PINDigit1]   ${PIN_NUMBER_DIGIT1}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit2]   ${PIN_NUMBER_DIGIT2}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit3]   ${PIN_NUMBER_DIGIT3}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit4]   ${PIN_NUMBER_DIGIT4}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit5]   ${PIN_NUMBER_DIGIT5}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit6]   ${PIN_NUMBER_DIGIT6}
    Click Item    ${ISIPulsaDetailsPage}[ConfirmButton]
    Sleep  3s
    Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
    ${TranscationStatus}=  get text    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
    log to console   ${TranscationStatus}
    Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationId]
    ${Transcationid}=  get text    ${ISIPulsaDetailsPage}[TranscationId]
    log to console   ${Transcationid}
    Click Item     ${ISIPulsaDetailsPage}[TranscationOk]
    capture page screenshot  Page.png
    Sleep  5s





ISI_Pulsa 1
    [Arguments]     ${data}


    ${MDN_NUMBER}=  getData  ${data}  MDN_Number
    ${RP_VALUE}=  getData  ${data}  RP_Value
    ${PAYMENT_TYPE}=  getData  ${data}  Payment_Type
    ${PIN_NUMBER_DIGIT1}=  getData  ${data}  PIN_NUMBER_Digit1
    ${PIN_NUMBER_DIGIT2}=  getData  ${data}  PIN_NUMBER_Digit2
    ${PIN_NUMBER_DIGIT3}=  getData  ${data}  PIN_NUMBER_Digit3
    ${PIN_NUMBER_DIGIT4}=  getData  ${data}  PIN_NUMBER_Digit4
    ${PIN_NUMBER_DIGIT5}=  getData  ${data}  PIN_NUMBER_Digit5
    ${PIN_NUMBER_DIGIT6}=  getData  ${data}  PIN_NUMBER_Digit6


    Log To Console  --------------- Executing ISI PULSA-----------------------------
    Log To Console  ${MDN_NUMBER}
    Log To Console  --------------- Executing ISI PULSA-----------------------------


    Set Input      ${ISIPulsaDetailsPage}[InputMDN]  ${MDN_NUMBER}
    Click Item     ${ISIPulsaDetailsPage}[InputMDNProceedButton]
    Set Input      ${ISIPulsaDetailsPage}[InputRPValue]  ${RP_VALUE}
    Click Item     ${ISIPulsaDetailsPage}[RPValueAddButton]
    Set Dropdown3  ${ISIPulsaDetailsPage}[PaymentTypeDropdown]  ${PAYMENT_TYPE}

    Click Item     ${ISIPulsaDetailsPage}[FinalProccedButton]
    Set Input      ${ISIPulsaDetailsPage}[PINDigit1]   ${PIN_NUMBER_DIGIT1}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit2]   ${PIN_NUMBER_DIGIT2}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit3]   ${PIN_NUMBER_DIGIT3}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit4]   ${PIN_NUMBER_DIGIT4}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit5]   ${PIN_NUMBER_DIGIT5}
    Set Input      ${ISIPulsaDetailsPage}[PINDigit6]   ${PIN_NUMBER_DIGIT6}
    Click Item     ${ISIPulsaDetailsPage}[ConfirmButton]

    Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
    capture page screenshot  ${SCREENSHOT_LOC}/Img_1.png
    ${TranscationStatus}=  get text    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
    log to console   ${TranscationStatus}
    Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationId]
    capture page screenshot  ${SCREENSHOT_LOC}/Img_2.png
    ${Transcationid}=  get text    ${ISIPulsaDetailsPage}[TranscationId]
    log to console   ${Transcationid}
    capture page screenshot  ${SCREENSHOT_LOC}/Img_3.png
    Click Item     ${ISIPulsaDetailsPage}[TranscationOk]
    capture page screenshot  ${SCREENSHOT_LOC}/Img_4.png

