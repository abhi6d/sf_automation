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

#${CRM_TestData}     ${TestData}[CRM_TestData]
${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
#${WKD_CRM_TESTDATA}     ${TestData}[WKD_CRM_TESTDATA]
${SmartFern_CREDENTIAL}     ${TestData}[USER][SmartFern_user]
${ISIPulsaDetailsPage}    ${wkd}[ISIPulsaDetailsPage]
${BeliPacketDetailsPage}    ${wkd}[BeliPacketDetailsPage]
${ADD_REFERENCE_KEY}  ${wkd}[ADD_REFERENCE_KEY]
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

    Click Item     ${ISIPulsaDetailsPage}[Apps]
    Click Item     ${ISIPulsaDetailsPage}[POSApp]
    Click Item     ${ISIPulsaDetailsPage}[ISIPulsa]

    FOR  ${i}  IN RANGE  0  ${data}-1

        ${data}=  Fetch Row Data  ${SMARTFREN_TESTDATA}  SMARTFREN_ISI_PULSA  ${i}

        ${TestCaseId}=  get_Value1  ${data}  TestCaseId
        ${TestDataId}=  get_Value1  ${data}  TestDataId
        ${RP_Value}=  get_Value1  ${data}  RP_Value
        ${MDN_NUMBER}=  get_Value1  ${data}  MDN_Number
        ${PAYMENT_TYPE}=  get_Value1  ${data}  Payment_Type
        ${Scenario}=  get_Value1  ${data}  Scenario
        ${PIN_NUMBER_DIGIT1}=  get_Value1  ${data}  PIN_NUMBER_Digit1
        ${PIN_NUMBER_DIGIT2}=  get_Value1  ${data}  PIN_NUMBER_Digit2
        ${PIN_NUMBER_DIGIT3}=  get_Value1  ${data}  PIN_NUMBER_Digit3
        ${PIN_NUMBER_DIGIT4}=  get_Value1  ${data}  PIN_NUMBER_Digit4
        ${PIN_NUMBER_DIGIT5}=  get_Value1  ${data}  PIN_NUMBER_Digit5
        ${PIN_NUMBER_DIGIT6}=  get_Value1  ${data}  PIN_NUMBER_Digit6

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


        IF    '${Scenario}' == 'NEGATIVE'
            Sleep  5s
            Log To Console  THIS_IS_THE_NEGATIVE SCENARIO
            capture page screenshot  ${SCREENSHOT_LOC}/${TestCaseId}_${TestDataId}_${Scenario}.png
            Click Item    //div[contains(text(),'Transaksi terdeteksi sebagai duplikat')]
            Click Item  (//div/img[@class='close-icon'])[1]
            Click Item  //div[@class='close-container']


        END

        IF    '${Scenario}' == 'POSITIVE'

            Log To Console  THIS_IS_THE_POSITIVE SCENARIO
            capture page screenshot  ${SCREENSHOT_LOC}/${TestCaseId}_${TestDataId}_${Scenario}.png
            Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
            ${TranscationStatus}=  get text    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
            log to console   ${TranscationStatus}
            Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationId]
            capture page screenshot  ${SCREENSHOT_LOC}/${TestCaseId}_${TestDataId}_${Scenario}.png
            ${Transcationid}=  get text    ${ISIPulsaDetailsPage}[TranscationId]
            log to console   ${Transcationid}
            Click Item     ${ISIPulsaDetailsPage}[TranscationOk]



        END

    END


Beli Paket 1
    [Arguments]     ${row}


    Click Item     ${BeliPacketDetailsPage}[Apps]
    Click Item     ${BeliPacketDetailsPage}[POSApp]
    Click Item     ${BeliPacketDetailsPage}[BeliPaket]

    FOR  ${i}  IN RANGE  0  ${row}-1

        ${data}=  Fetch Row Data  ${SMARTFREN_TESTDATA}  SMARTFREN_BELI_PAKET  ${i}

        ${TestCaseId}=  get_Value1  ${data}  TestCaseId
        ${TestDataId}=  get_Value1  ${data}  TestDataId
        ${MDN_NUMBER}=  get_Value1  ${data}  MDN_Number
        ${PACKAGE}=  get_Value1  ${data}  Package
        ${RP_VALUE}=  get_Value1  ${data}  RP_Value
        ${PAYMENT_TYPE}=  get_Value1  ${data}  Payment_Type
        ${PIN_NUMBER_DIGIT1}=  get_Value1  ${data}  PIN_NUMBER_Digit1
        ${PIN_NUMBER_DIGIT2}=  get_Value1  ${data}  PIN_NUMBER_Digit2
        ${PIN_NUMBER_DIGIT3}=  get_Value1  ${data}  PIN_NUMBER_Digit3
        ${PIN_NUMBER_DIGIT4}=  get_Value1  ${data}  PIN_NUMBER_Digit4
        ${PIN_NUMBER_DIGIT5}=  get_Value1  ${data}  PIN_NUMBER_Digit5
        ${PIN_NUMBER_DIGIT6}=  get_Value1  ${data}  PIN_NUMBER_Digit6
        ${Scenario}=  get_Value1  ${data}  Scenario
        ${MESSAGE}=  get_Value1  ${data}  MESSAGE

        Log To Console  ===========================================================
        Log To Console  ${TestCaseId}
        Log To Console  ===========================================================

        Set Input      ${BeliPacketDetailsPage}[InputMDN]  ${MDN_NUMBER}
        Click Item     ${BeliPacketDetailsPage}[InputMDNProceedButton]
        Set Input      ${BeliPacketDetailsPage}[SearchPackage]    ${PACKAGE}
        Click Item     (//div[contains(text(),'${RP_Value}')])[1]
        Set Dropdown3  ${BeliPacketDetailsPage}[PaymentTypeDropdown]  ${PAYMENT_TYPE}
        Click Item     ${BeliPacketDetailsPage}[FinalProccedButton]
        Set Input      ${ISIPulsaDetailsPage}[PINDigit1]   ${PIN_NUMBER_DIGIT1}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit2]   ${PIN_NUMBER_DIGIT2}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit3]   ${PIN_NUMBER_DIGIT3}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit4]   ${PIN_NUMBER_DIGIT4}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit5]   ${PIN_NUMBER_DIGIT5}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit6]   ${PIN_NUMBER_DIGIT6}
        Click Item    ${ISIPulsaDetailsPage}[ConfirmButton]


        IF    '${Scenario}' == 'POSITIVE'
            Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
            ${TranscationStatus}=  get text    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
            log to console   ${TranscationStatus}
            Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationId]
            ${Transcationid}=  get text    ${ISIPulsaDetailsPage}[TranscationId]
            capture page screenshot  ${SCREENSHOT_LOC}/Beli_Packet_${TestCaseId}_${TestDataId}_${Scenario}.png
            log to console   ${Transcationid}
            Click Item     ${ISIPulsaDetailsPage}[TranscationOk]
            capture page screenshot  Page.png


        END

        IF    '${Scenario}' == 'NEGATIVE'
            Sleep  5s
            Log To Console  THIS_IS_THE_NEGATIVE SCENARIO
            Verify elements is visible and displayed    //div[contains(text(),'${MESSAGE}')]
            #Click Item    //div[contains(text(),'Transaksi terdeteksi sebagai duplikat')]
            Click Item    //div[contains(text(),'Transaksi terdeteksi sebagai duplikat')]
            #capture page screenshot  ${SCREENSHOT_LOC}/Beli_Packet_${TestCaseId}_${TestDataId}_${Scenario}.png
            Click Item  (//div/img[@class='close-icon'])[1]
            Click Item  //div[@class='close-container']


        END

    END
   # Verify elements is visible and displayed    //div[contains(text(),'${MESSAGE}')]


Outlet Creation 1
    [Arguments]     ${row}


    Log To Console  ${row}

    FOR  ${i}  IN RANGE  0  ${row}-1

        ${data}=  Fetch Row Data  ${SMARTFREN_TESTDATA}  SMARTFERN_OUTLET_CREATION  ${i}
        ${TestCaseId}=  get_Value1  ${data}  TestCaseId
        ${TestDataId}=  get_Value1  ${data}  TestDataId
        ${WEEKDAY}=  get_Value1  ${data}  WEEKDAY
        #Log To Console  ${WEEKDAY}
        ${len}=  List len  ${WEEKDAY}

        Click Item     ${ADD_REFERENCE_KEY}[Apps]

        ${present}=  Run Keyword And Return Status    Element Should Be Visible   ${ADD_REFERENCE_KEY}[DMS]
        Run Keyword If    ${present}    Click Item  ${ADD_REFERENCE_KEY}[DMS]

        Click Item  //span[text()='Channel Partner']
        Click Item  //a[normalize-space()='Outlet Mangement']
        Click Item  //div[contains(text(),' Create')]


#        FOR  ${index}  IN RANGE  0  ${len}-1
#            #Log To Console  ${len}
#            ${Value}=  List Value  ${WEEKDAY}  ${index}
#            Log To Console  ${Value}
#            #Click Item  //div[contains(text(),'${Value}')]
#            Sleep  5s
#        END

        Set Accordian  ${WEEKDAY}  ${len}

        Set TextArea  //textarea[@id='address__id']  8765556666

    END
#    Click Item     ${BeliPacketDetailsPage}[Apps]
#    Click Item     ${BeliPacketDetailsPage}[POSApp]
#    Click Item     ${BeliPacketDetailsPage}[BeliPaket]



