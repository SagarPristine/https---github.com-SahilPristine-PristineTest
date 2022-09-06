#Pragma warning Disable
codeunit 50000 "ProcessTransfer-Post (Yes/No)"
{
    // 1) Case 0 Negative Adj. of Total Avg. Qty. (i.e. Lint/Remenant Qty. = 0)
    // 2) 2.a) Case 1 Negative Adj. of Lint/Remenant Qty.
    //    2.b) Case 2 Negative Adj. of (Total Avg. Qty. - Lint/Remenant Qty.)
    // 3) Case 3 Positive Adj. of Good Qty.



    TableNo = "Process Header";


    trigger OnRun()
    begin
        IF NOT FIND THEN
            ERROR(NothingToPostErr);

        rec50007.COPY(Rec);
        Code;
        Rec := rec50007;
        IF Rec.Status = Rec.Status::Complete THEN
            MESSAGE('Document No. %1 is Posted', rec50007."No.");
    end;

    var
        Text001: Label 'Do you want to post the %1?';
        rec50007: Record "Process Header";
        Selection: Integer;
        Text13700: Label 'You have to attach transit document for this invoice.';
        Text13701: Label 'Transit document(s) are not required  for this invoice.';
        PreviewMode: Boolean;
        NothingToPostErr: Label 'There is nothing to post.';
        Text000: Label 'Item Journal Line already exists against the Transfer, Do you want to Proceed by Modifing it?';
        lineno: Integer;
        documentno: Text[30];
        Location: Record Location;
        WMSMgmt: Codeunit "WMS Management";
        ItemJnlTemplate: Record "Item Journal Template";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recUL: Record "User Location";
        recLoc: Record Location;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
        Text002: Label 'Location Code %1 %2 ''''. It cannot be Blank.';
        SampleCode: Code[20];
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        recItem: Record Item;
        "----------------------------For Checking Rvd------------------------------------": Integer;
        RecProcessLine: Record "Process Line";
        CheckRvdForTrue: Boolean;
        CheckRvdForFalse: Boolean;
        opt: Option "Process Transfer","Posted Process Transfer",BSIO,"Posted BSIO",FSIO,"Posted FSIO","Seed Arrival","Posted Seed Arrival","Planting List","Posted Planting List","Hybrid Seed Arrival","Posted hybrid Seed Arrival","Inspection I","Posted Inspection I","Inspection II","Posted Inspection II","Inspection III","Posted Inspection III","Inspection IV","Posted Inspection IV","Inspection QC","Posted Inspection QC",Blend,"Posted Blend","Organizer Arrival","Posted Organizer Arrival","Organizer Process Transfer","Posted Organizer Process Transfer","Org Outward Gate Entry","Posted Org Outward Gate Entry","Marketing Indent","Posted Marketing Indent","Delivery Order","Posted Delivery Order","Hybrid Sales Order","Posted Hybrid Sales Order.","Non Seed Indent","Posted Non Seed Indent",RVD,"Posted RVD","Sucker Receipt","Posted Sucker Receipt","Tissue Culture PT","Posted Tissue Culture PT","Tissue Culture Contamination ","Posted Tissue Culture Contamination","Posted Seed Arrival FSIO Rece","Posted Seed Arrival Hybrid Rec","Posted Seed Arrival FSIO Invoi","Posted Seed Arrival Hybrid Inv","Grower Master","Crop Master","Crop Stage Master","Season Master","Item Group Master","Geographical Setup Master","Zone Master","Taluka Master","Region Master","State Master","District Master","Parent Seed Master","Lot Range Master","Party Master",Got,BtElisa,Retest;
        Vartotal: Integer;


    [TryFunction]
    local procedure "Code"()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        SalesPost: Codeunit "Sales-Post";
        RecItemJnlLine: Record "Item Journal Line";
        "------For Bin Warehouse Movement-----": Text;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        TTrec27: Record Item;
        rec83: Record "Item Journal Line";
        rec337: Record "Reservation Entry";
    begin
        //Check Details
        CheckDetailsProcessTransfer(rec50007);
        WITH rec50007 DO
            CASE Status OF
                Status::Open:
                    BEGIN
                        IF NOT CONFIRM(Text001, FALSE, "No.") THEN
                            EXIT;
                    END;
                ELSE
                    ERROR('Status Should be %1', Status::Open);
            END;


        rec83.RESET;


        //Check RVD
        CheckRvdForTrue := FALSE;
        CheckRvdForFalse := FALSE;
        RecProcessLine.RESET;
        RecProcessLine.SETCURRENTKEY("Document No.", "Line No.", RVD);
        RecProcessLine.SETRANGE("Document No.", rec50007."No.");
        IF RecProcessLine.FINDSET THEN BEGIN
            REPEAT
                IF RecProcessLine.RVD = TRUE THEN
                    CheckRvdForTrue := TRUE;
                IF RecProcessLine.RVD = FALSE THEN
                    CheckRvdForFalse := TRUE;
            UNTIL RecProcessLine.NEXT = 0;
        END;
        IF (CheckRvdForTrue = TRUE) AND (CheckRvdForFalse = TRUE) THEN
            ERROR('You Cannot select RVD Lot & Non RVD Lot at the same time.');


        //Get QC LabCode/SampleCode For RVD FALSE
        /*they put it manual
        IF (CheckRvdForTrue = FALSE) AND (CheckRvdForFalse = TRUE) THEN BEGIN
          IF TTrec27.GET(rec50007."Item No.") THEN BEGIN
            IF (TTrec27."Class of Seeds" = TTrec27."Class of Seeds"::Foundation) OR (TTrec27."Class of Seeds" = TTrec27."Class of Seeds"::TL) THEN BEGIN
              //getting sample code from lot Range
              IF rec50007."From Stage" = 'RAW' THEN
                GetNewSampleCode(rec50007)
              ELSE
                GetOldSampleCode(rec50007);
              IF SampleCode = '' THEN
                ERROR('Lot Range is not defined for Item No. %1 with Location %2.',rec50007."Item No.",rec50007.Location);
            END;
          END;
        END;
        */

        //Creating IJL
        CheckEntryType(rec50007);

        //Posting IJL Start
        IF documentno = '' THEN
            ERROR('Posted Document No. doesnot found.');
        RecItemJnlLine.RESET;
        RecItemJnlLine.SETCURRENTKEY("Document No.");
        RecItemJnlLine.SETRANGE("Document No.", documentno);
        IF RecItemJnlLine.FINDSET THEN BEGIN
            REPEAT
                ItemJnlPostLine.RunWithCheck(RecItemJnlLine);
                ItemJnlPostLine.CollectTrackingSpecification(TempTrackingSpecification);
                PostWhseJnlLine(RecItemJnlLine, RecItemJnlLine.Quantity, RecItemJnlLine."Quantity (Base)", TempTrackingSpecification);
            UNTIL RecItemJnlLine.NEXT = 0;
        END ELSE
            MESSAGE('IJL Table is Empty.');
        RecItemJnlLine.RESET;
        RecItemJnlLine.SETCURRENTKEY("Document No.");
        RecItemJnlLine.SETRANGE("Document No.", documentno);
        IF RecItemJnlLine.FINDSET THEN
            RecItemJnlLine.DELETEALL;
        //Posting IJL End


        //Creating QC LabCode/SampleCode
        //Blocked
        // IF rec50007."RVD Opening" THEN //LK
        // CreateQCSampleRVDOpening(rec50007)
        // ELSE
        // CreateQCSample(rec50007);
        //Blocked
        // OldCode
        // //Creating QC LabCode/SampleCode For RVD FALSE
        // IF (CheckRvdForTrue = FALSE) AND (CheckRvdForFalse = TRUE) THEN
        //  CreateQCSample(rec50007);

        //Create Lot No. Information for Expiry Checking
        //Blocked   
        // IF rec50007."To Stage" = 'PACKED' THEN BEGIN
        // recItem.RESET;
        // IF recItem.GET(rec50007."Item No.") THEN BEGIN
        //     IF (recItem."Class of Seeds" = recItem."Class of Seeds"::TL) THEN BEGIN
        //         CreateLotNoInfo(rec50007);
        //     END;
        // END;
        // END;
        ////Blocked

        //Posting PT
        IF Post(rec50007) THEN
            rec50007.Status := rec50007.Status::Complete;


    end;

    local procedure CheckDetailsProcessTransfer(var Trec50007: Record "Process Header")
    var
        Trec50008: Record "Process Line";
        rec27: Record Item;
    begin
        Trec50007.TESTFIELD(Date);
        Trec50007.TESTFIELD("Crop Code");
        Trec50007.TESTFIELD("Item No.");
        Trec50007.TESTFIELD(Season);
        //Trec50007.TESTFIELD("Sample Code");
        Trec50007.TESTFIELD(Status, Trec50007.Status::Open);
        Trec50008.RESET;
        Trec50008.SETCURRENTKEY("Document No.");
        Trec50008.SETRANGE("Document No.", Trec50007."No.");
        IF NOT Trec50008.FINDFIRST THEN
            ERROR(NothingToPostErr);
        Trec50008.RESET;
        Trec50008.SETCURRENTKEY("Document No.", "Line No.");
        Trec50008.SETRANGE("Document No.", Trec50007."No.");
        IF Trec50008.FINDSET THEN BEGIN
            REPEAT
                //050520Demo
                //IF Trec50008."Required Bags" <> (Trec50008."Good No. of Bags" + Trec50008."Lint No. of Bags" + Trec50008."Remenant No. of Bags") THEN
                //ERROR('No. of Bags used must be equal to Required No. of Bags.');
                Trec50008.TESTFIELD("Good No. of Bags/Pckt");
                Trec50008.TESTFIELD("Good Qty.");
                Trec50008.TESTFIELD("To Location Code");
                Trec50008.TESTFIELD("To Bin/Stack Code");
                IF Trec50008."To Stage" <> 'PACKED' THEN
                    //IF (Trec50008."Total Avai. Qty." < (Trec50008."Good Qty." + Trec50008."Lint Qty." + Trec50008."Remenant Qty." + Trec50008."Process Loss Qty.")) THEN
                    IF (Trec50008."Required Qty." <> (Trec50008."Good Qty." + Trec50008."Lint Qty." + Trec50008."Remenant Qty." + Trec50008."Process Loss Qty." + Trec50008."Sample Qty.")) THEN
                        ERROR('Quantity taken should be less than Avai. Quantity.');
                IF Trec50008."To Stage" = 'PACKED' THEN BEGIN
                    rec27.RESET;
                    IF rec27.GET(Trec50008."Item No.") THEN BEGIN
                        IF rec27."Class of Seeds" = rec27."Class of Seeds"::Breeder THEN BEGIN
                            Trec50008.TESTFIELD("Packed Item Code");
                            Trec50008.TESTFIELD("Marketing Lot No.");
                            Trec50008.TESTFIELD("Packing By");
                        END ELSE
                            IF rec27."Class of Seeds" = rec27."Class of Seeds"::Foundation THEN BEGIN
                                Trec50008.TESTFIELD("Packed Item Code");
                                Trec50008.TESTFIELD("Marketing Lot No.");
                                Trec50008.TESTFIELD("Packing By");
                            END ELSE
                                IF rec27."Class of Seeds" = rec27."Class of Seeds"::TL THEN BEGIN
                                    Trec50008.TESTFIELD("Packed Item Code");
                                    Trec50008.TESTFIELD("Marketing Lot No.");
                                    Trec50008.TESTFIELD("Packing By");
                                    Trec50008.TESTFIELD("Quality Test Date");
                                    Trec50008.TESTFIELD("Expiry Date");

                                    IF ((Trec50008."Good No. of Bags/Pckt" + Trec50008."Sample No. of Bags/Pckt") <> Trec50008."Total Label") THEN
                                        ERROR('Good No. of Bags/Pckt %1 must be equal to Total Label %2.', Trec50008."Good No. of Bags/Pckt", Trec50008."Total Label");
                                END;
                    END;
                END;
            UNTIL Trec50008.NEXT = 0;
        END;
    end;

    local procedure CheckEntryType(var Trec50007: Record "Process Header")
    var
        Trec50008: Record "Process Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        rec83: Record "Item Journal Line";
        ItemJnlBatch: Record "Item Journal Batch";
        recCSM: Record "Crop Stage Master";
        IJL2: Record "Item Journal Line";
        IJL: Record "Item Journal Line";
        lineno3: Integer;
        Item: Record Item;
    begin
        CLEAR(lineno);
        //No. Series For Item Journal Document No.
        recUL.RESET;
        recUL.SETCURRENTKEY("User ID");
        recUL.SETRANGE("User ID", USERID);
        recUL.SETRANGE("Location Code", Trec50007.Location);//050520Demo
        recUL.SETRANGE("Process Invoice Header", TRUE);
        IF recUL.FINDFIRST THEN BEGIN
            IF recLoc.GET(Trec50007.Location) THEN BEGIN
                recLoc.TESTFIELD("Post Process Transfer No.");
                documentno := NoSeriesMgt.GetNextNo(recLoc."Post Process Transfer No.", Trec50007.Date, true);
            END ELSE
                ERROR(Text002, Trec50007.Location, recLoc.FIELDCAPTION("Post Process Transfer No."));
        END ELSE
            ERROR(ContactAdminText003);

        //lineno
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Process Transfer Template Name");
        PurchSetup.TESTFIELD("Process Transfer Batch Name");
        rec83.RESET;
        rec83.SETCURRENTKEY("Journal Template Name", "Journal Batch Name");
        rec83.SETRANGE("Journal Template Name", PurchSetup."Process Transfer Template Name");
        rec83.SETRANGE("Journal Batch Name", PurchSetup."Process Transfer Batch Name");
        IF rec83.FINDLAST THEN
            lineno := rec83."Line No." + 10000
        ELSE
            lineno := rec83."Line No." + 10000;
        rec83.RESET;

        Trec50008.RESET;
        Trec50008.SETCURRENTKEY("Document No.", "Line No.");
        Trec50008.SETRANGE("Document No.", Trec50007."No.");
        IF Trec50008.FINDSET THEN BEGIN
            REPEAT
                //GQ
                IF Trec50008."Good Qty." <> 0 THEN BEGIN
                    //lineno += 10000;
                    ItemJnrlPost(rec50007, Trec50008, 2, rec50007."To Stage", 0, lineno, documentno); //+ve GQ
                    lineno += 10000;
                    ItemJnrlPost(rec50007, Trec50008, 3, rec50007."From Stage", 1, lineno, documentno); //-ve GQ
                    lineno += 10000;
                END;
                //LQ
                IF Trec50008."Lint Qty." <> 0 THEN BEGIN
                    recCSM.RESET;
                    // recCSM.SETCURRENTKEY("Crop Code", "Lint/Remenant", "Type");
                    recCSM.SETCURRENTKEY("Crop Code", "Lint/Remenant");
                    recCSM.SETRANGE("Crop Code", rec50007."Crop Code");
                    recCSM.SETRANGE("Lint/Remenant", recCSM."Lint/Remenant"::Lint);
                    //recCSM.SETRANGE(Type, recCSM.Type::"Process Transfer");
                    IF NOT recCSM.FINDFIRST THEN
                        ERROR('Crop Stage Master doesnot exist for Crop Code %1, Lint\Remenant Lint.', rec50007."Crop Code");
                    ItemJnrlPost(rec50007, Trec50008, 2, recCSM.Stage, 2, lineno, documentno); //+ve LQ
                    lineno += 10000;
                    ItemJnrlPost(rec50007, Trec50008, 3, rec50007."From Stage", 3, lineno, documentno); //-ve LQ
                    lineno += 10000;
                END;
                //RQ
                IF Trec50008."Remenant Qty." <> 0 THEN BEGIN
                    recCSM.RESET;
                    //ecCSM.SETCURRENTKEY("Crop Code", "Lint/Remenant", Type);
                    recCSM.SETCURRENTKEY("Crop Code", "Lint/Remenant");
                    recCSM.SETRANGE("Crop Code", rec50007."Crop Code");
                    recCSM.SETRANGE("Lint/Remenant", recCSM."Lint/Remenant"::Remenant);
                    //recCSM.SETRANGE(Type, recCSM.Type::"Process Transfer");
                    IF NOT recCSM.FINDFIRST THEN
                        ERROR('Crop Stage Master doesnot exist for Crop Code %1, Lint\Remenant Remenant.', rec50007."Crop Code");
                    ItemJnrlPost(rec50007, Trec50008, 2, recCSM.Stage, 4, lineno, documentno); //+ve RQ
                    lineno += 10000;
                    ItemJnrlPost(rec50007, Trec50008, 3, rec50007."From Stage", 5, lineno, documentno); //-ve RQ
                    lineno += 10000;
                END;
                //PL
                IF Trec50008."Process Loss Qty." <> 0 THEN BEGIN
                    ItemJnrlPost(rec50007, Trec50008, 3, rec50007."From Stage", 6, lineno, documentno); //-ve PL
                    lineno += 10000;
                END;
                //SQ
                Trec50007.CALCFIELDS("Class of Seeds");
                IF Trec50007."Class of Seeds" = Trec50007."Class of Seeds"::TL THEN BEGIN
                    IF Trec50008."Sample Qty." <> 0 THEN BEGIN
                        ItemJnrlPost(rec50007, Trec50008, 2, rec50007."To Stage", 7, lineno, documentno); //+ve SQ
                        lineno += 10000;
                        ItemJnrlPost(rec50007, Trec50008, 3, rec50007."From Stage", 8, lineno, documentno); //-ve SQ
                        lineno += 10000;
                    END;
                END;
            UNTIL Trec50008.NEXT = 0;
        END;
        //create Consumption Entries
        Trec50008.RESET;
        Trec50008.SETCURRENTKEY("Document No.", "Line No.");
        Trec50008.SETRANGE("Document No.", Trec50007."No.");
        Trec50008.SETRANGE("Entry Type", Trec50008."Entry Type"::Consumption);
        IF Trec50008.FINDSET THEN BEGIN
            REPEAT
                PurchSetup.GET;
                PurchSetup.TESTFIELD("Process Transfer Template Name");
                PurchSetup.TESTFIELD("Process Transfer Batch Name");
                IJL2.RESET;
                IJL2.SETRANGE("Journal Template Name", 'ITEM');
                IJL2.SETRANGE("Journal Batch Name", 'CONSMPTN');
                IF IJL2.FINDLAST THEN
                    lineno3 := IJL2."Line No." + 10000
                ELSE
                    lineno3 := 10000;

                IJL.INIT;
                IJL.VALIDATE("Journal Template Name", 'ITEM');
                IJL.VALIDATE("Journal Batch Name", 'CONSMPTN');
                IJL.VALIDATE("Line No.", lineno3);
                IJL."Document No." := documentno;
                IJL.VALIDATE("Posting Date", rec50007.Date);
                IJL."External Document No." := 'CONSUMPTION';
                IJL.VALIDATE("Entry Type", IJL."Entry Type"::"Negative Adjmt.");
                IJL.VALIDATE("Item No.", Trec50008."Item No.");
                IJL.VALIDATE("Location Code", rec50007.Location);
                IJL.VALIDATE("Bin Code", 'BINALL');
                Item.GET(Trec50008."Item No.");
                IJL.VALIDATE("Unit Cost", Item."Unit Cost");
                IJL.VALIDATE(Quantity, Trec50008."Total Avai. Qty.");
                IJL.INSERT;
            UNTIL Trec50008.NEXT = 0;
        END;
        //create Consumption Entries
    end;

    local procedure ItemJnrlPost(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; EntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output"; var VariantCode: Code[50]; CaseNo: Option Zero,One,Two,Three,Four,Five,Six,Seven,Eight; Tlineno: Integer; Tdocumentno: Text)
    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        rec83: Record "Item Journal Line";
        ItemJnlBatch: Record "Item Journal Batch";
        rec27: Record Item;
        "ItemJnl.-PostLine": Codeunit "Item Jnl.-Post Line";
        ReservationEntry: Record "Reservation Entry";
        entryno: Integer;
        GenPostingSetup: Record "General Posting Setup";
    begin
        //*********************Var Details
        //*********************VarName      DataTypeSubtype
        //*********************Trec50007    Record  Process Header
        //*********************Trec50008    Record  Process Line
        //*********************EntryType    Option//Selecting EntryType
        //*********************VariantCode  Text  //Selecting VariantCode(i.e. From Stage)

        PurchSetup.GET;
        PurchSetup.TESTFIELD("Process Transfer Template Name");
        PurchSetup.TESTFIELD("Process Transfer Batch Name");
        rec83.INIT;
        rec83."Journal Template Name" := PurchSetup."Process Transfer Template Name";
        rec83."Journal Batch Name" := PurchSetup."Process Transfer Batch Name";
        rec83."Line No." := Tlineno;
        rec83."Document No." := Tdocumentno;
        rec83.VALIDATE("Posting Date", Trec50007.Date);
        rec83.VALIDATE("Document Date", Trec50007.Date);
        rec83."Entry Type" := EntryType;
        rec83."Crop Code" := Trec50007."Crop Code";

        //for packing
        IF Trec50007."To Stage" = 'PACKED' THEN BEGIN
            recItem.RESET;
            IF recItem.GET(Trec50007."Item No.") THEN BEGIN
                IF (recItem."Class of Seeds" = recItem."Class of Seeds"::TL) THEN BEGIN
                    IF CaseNo = CaseNo::Zero THEN
                        rec83.VALIDATE("Item No.", Trec50008."Packed Item Code")
                    ELSE
                        IF CaseNo = CaseNo::Seven THEN
                            rec83.VALIDATE("Item No.", Trec50008."Packed Item Code")
                        ELSE
                            rec83.VALIDATE("Item No.", Trec50007."Item No.");
                END;
                IF (recItem."Class of Seeds" = recItem."Class of Seeds"::Foundation) THEN BEGIN
                    IF CaseNo = CaseNo::Zero THEN
                        rec83.VALIDATE("Item No.", Trec50008."Packed Item Code")
                    ELSE
                        rec83.VALIDATE("Item No.", Trec50007."Item No.");
                END;
                IF (recItem."Class of Seeds" = recItem."Class of Seeds"::Breeder) THEN BEGIN
                    IF CaseNo = CaseNo::Zero THEN
                        rec83.VALIDATE("Item No.", Trec50008."Packed Item Code")
                    ELSE
                        rec83.VALIDATE("Item No.", Trec50007."Item No.");
                END;
            END;
        END;
        IF Trec50007."To Stage" <> 'PACKED' THEN
            rec83.VALIDATE("Item No.", Trec50007."Item No.");

        //for different location
        IF CaseNo = CaseNo::Zero THEN BEGIN
            Trec50008.TESTFIELD("To Location Code");
            rec83."Location Code" := Trec50008."To Location Code"
        END ELSE
            IF CaseNo = CaseNo::Seven THEN BEGIN
                Trec50008.TESTFIELD("Sample Location Code");
                rec83."Location Code" := Trec50008."Sample Location Code"
            END ELSE BEGIN
                rec83."Location Code" := Trec50007.Location;
            END;

        rec83."Qty. per Unit of Measure" := 1;
        IF rec27.GET(rec83."Item No.") THEN BEGIN
            //oldAjeetSeeds IF rec27.GET(Trec50007."Item No.") THEN BEGIN
            rec83."Unit of Measure Code" := rec27."Base Unit of Measure";
            rec83."Inventory Posting Group" := rec27."Inventory Posting Group";
            rec83.Description := rec27.Description;
            rec83."Item Category Code" := rec27."Item Category Code";
            // rec83."Product Group Code" := rec27."Product Group Code";
            rec83."Class of Seeds" := rec27."Class of Seeds";
            rec83."Item Type" := rec27."Item Type";
            rec83."FG Pack Size" := rec27."FG Pack Size";
            //rec83."Production Code" := rec27."Production Code";
            //rec83."Marketing Code" := rec27."Marketing Code";
            rec83."Variety Code" := rec27."Variety Code";
            rec83."Crop Type" := rec27."Crop Type";
            rec83."Hybrid Type" := rec27."Hybrid Type";
            //rec83."Prefix No." := Trec50008."Prefix No.";
            IF rec27."Class of Seeds" = rec27."Class of Seeds"::TL THEN
                IF CaseNo = CaseNo::Zero THEN BEGIN
                    IF Trec50007."To Stage" = 'PACKED' THEN BEGIN
                        rec83."Expiry Date" := Trec50008."Expiry Date";
                        rec83."Packing By" := Trec50008."Packing By";
                        rec83."Quality Test Date" := Trec50008."Quality Test Date";
                    END;
                END;
            IF CaseNo = CaseNo::Seven THEN BEGIN
                IF Trec50007."To Stage" = 'PACKED' THEN BEGIN
                    rec83."Expiry Date" := Trec50008."Expiry Date";
                    rec83."Packing By" := Trec50008."Packing By";
                    rec83."Quality Test Date" := Trec50008."Quality Test Date";
                END;
            END;
        END;
        GenPostingSetup.RESET;
        GenPostingSetup.SETRANGE(GenPostingSetup."Gen. Prod. Posting Group", rec27."Gen. Prod. Posting Group");
        IF GenPostingSetup.FIND('-') THEN
            rec83."Gen. Bus. Posting Group" := GenPostingSetup."Gen. Bus. Posting Group";
        rec83."Source Code" := 'ITEMJNL';
        rec83."Variant Code" := VariantCode;
        rec83."Season Code" := Trec50007.Season;
        rec83.RVD := Trec50008.RVD;
        // IF Trec50007.Regrading = TRUE THEN
        //     rec83.Regrading := Trec50007.Regrading;
        // IF Trec50007.RVD = TRUE THEN
        //     rec83.RVD := Trec50007.RVD;

        IF CaseNo = CaseNo::Zero THEN BEGIN             //+ve GQ
            rec83."Bin Code" := Trec50008."To Bin/Stack Code";
        END ELSE
            IF CaseNo = CaseNo::One THEN BEGIN     //-ve GQ
                rec83."Bin Code" := Trec50008."From Bin/Stack Code";
            END ELSE
                IF CaseNo = CaseNo::Two THEN BEGIN     //+ve LQ
                    rec83."Bin Code" := Trec50008."Lint Bin/Stack Code";
                END ELSE
                    IF CaseNo = CaseNo::Three THEN BEGIN   //-ve LQ
                        rec83."Bin Code" := Trec50008."From Bin/Stack Code";
                    END ELSE
                        IF CaseNo = CaseNo::Four THEN BEGIN    //+ve RQ
                            rec83."Bin Code" := Trec50008."Remenant Bin/Stack Code";
                        END ELSE
                            IF CaseNo = CaseNo::Five THEN BEGIN    //-ve RQ
                                rec83."Bin Code" := Trec50008."From Bin/Stack Code";
                            END ELSE
                                IF CaseNo = CaseNo::Six THEN BEGIN     //-ve PL
                                    rec83."Bin Code" := Trec50008."From Bin/Stack Code";
                                END ELSE
                                    IF CaseNo = CaseNo::Seven THEN BEGIN    //+ve SQ
                                        rec83."Bin Code" := Trec50008."To Bin/Stack Code";
                                    END ELSE
                                        IF CaseNo = CaseNo::Eight THEN BEGIN    //-ve SQ
                                            rec83."Bin Code" := Trec50008."From Bin/Stack Code";
                                        END;
        // IF Trec50007."To Stage" <> 'PACKED' THEN
        //     rec83."Year and State" := Trec50008."Year and State";
        CheckQuantity(rec83, Trec50008, EntryType, CaseNo);
        CheckDetailsItemJournal(rec83, Trec50007."No.");

        //ReservationEntry for Lot Tracking
        ReservationEntry.RESET;
        IF ReservationEntry.FINDLAST THEN
            entryno := ReservationEntry."Entry No." + 1
        ELSE
            entryno := 1;
        ReservationEntry.INIT;
        ReservationEntry."Entry No." := entryno;
        ReservationEntry."Item No." := rec83."Item No.";
        IF CaseNo = CaseNo::Zero THEN BEGIN             //+ve GQ
            ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"2";
            ReservationEntry.Quantity := rec83.Quantity;
            ReservationEntry."Quantity (Base)" := rec83.Quantity;
            ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity;
            ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity;
            ReservationEntry."Expected Receipt Date" := rec83."Posting Date";
            ReservationEntry."No. of Bags/Pckt" := Trec50008."Good No. of Bags/Pckt";
        END ELSE
            IF CaseNo = CaseNo::One THEN BEGIN     //-ve GQ
                ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"3";
                ReservationEntry.Quantity := rec83.Quantity * -1;
                ReservationEntry."Quantity (Base)" := rec83.Quantity * -1;
                ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity * -1;
                ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity * -1;
                ReservationEntry."Shipment Date" := rec83."Posting Date";
                ReservationEntry."No. of Bags/Pckt" := Trec50008."Good No. of Bags/Pckt";
            END ELSE
                IF CaseNo = CaseNo::Two THEN BEGIN     //+ve LQ
                    ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"2";
                    ReservationEntry.Quantity := rec83.Quantity;
                    ReservationEntry."Quantity (Base)" := rec83.Quantity;
                    ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity;
                    ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity;
                    ReservationEntry."Expected Receipt Date" := rec83."Posting Date";
                    ReservationEntry."No. of Bags/Pckt" := Trec50008."Lint No. of Bags/Pckt";
                END ELSE
                    IF CaseNo = CaseNo::Three THEN BEGIN   //-ve LQ
                        ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"3";
                        ReservationEntry.Quantity := rec83.Quantity * -1;
                        ReservationEntry."Quantity (Base)" := rec83.Quantity * -1;
                        ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity * -1;
                        ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity * -1;
                        ReservationEntry."Shipment Date" := rec83."Posting Date";
                        ReservationEntry."No. of Bags/Pckt" := Trec50008."Lint No. of Bags/Pckt";
                    END ELSE
                        IF CaseNo = CaseNo::Four THEN BEGIN    //+ve RQ
                            ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"2";

                            ReservationEntry.Quantity := rec83.Quantity;
                            ReservationEntry."Quantity (Base)" := rec83.Quantity;
                            ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity;
                            ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity;
                            ReservationEntry."Expected Receipt Date" := rec83."Posting Date";
                            ReservationEntry."No. of Bags/Pckt" := Trec50008."Remenant No. of Bags/Pckt";
                        END ELSE
                            IF CaseNo = CaseNo::Five THEN BEGIN    //-ve RQ
                                ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"3";
                                ReservationEntry.Quantity := rec83.Quantity * -1;
                                ReservationEntry."Quantity (Base)" := rec83.Quantity * -1;
                                ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity * -1;
                                ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity * -1;
                                ReservationEntry."Shipment Date" := rec83."Posting Date";
                                ReservationEntry."No. of Bags/Pckt" := Trec50008."Remenant No. of Bags/Pckt";
                            END ELSE
                                IF CaseNo = CaseNo::Six THEN BEGIN     //-ve PL
                                    ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"3";
                                    ReservationEntry.Quantity := rec83.Quantity * -1;
                                    ReservationEntry."Quantity (Base)" := rec83.Quantity * -1;
                                    ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity * -1;
                                    ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity * -1;
                                    ReservationEntry."Shipment Date" := rec83."Posting Date";
                                END ELSE
                                    IF CaseNo = CaseNo::Seven THEN BEGIN   //+ve SQ
                                        ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"2";
                                        ReservationEntry.Quantity := rec83.Quantity;
                                        ReservationEntry."Quantity (Base)" := rec83.Quantity;
                                        ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity;
                                        ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity;
                                        ReservationEntry."Expected Receipt Date" := rec83."Posting Date";
                                        ReservationEntry."No. of Bags/Pckt" := Trec50008."Sample No. of Bags/Pckt";
                                    END ELSE
                                        IF CaseNo = CaseNo::Eight THEN BEGIN   //-ve SQ
                                            ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"3";
                                            ReservationEntry.Quantity := rec83.Quantity * -1;
                                            ReservationEntry."Quantity (Base)" := rec83.Quantity * -1;
                                            ReservationEntry."Qty. to Handle (Base)" := rec83.Quantity * -1;
                                            ReservationEntry."Qty. to Invoice (Base)" := rec83.Quantity * -1;
                                            ReservationEntry."Shipment Date" := rec83."Posting Date";
                                            ReservationEntry."No. of Bags/Pckt" := Trec50008."Sample No. of Bags/Pckt";
                                        END;

        IF Trec50007."To Stage" = 'PACKED' THEN BEGIN
            recItem.RESET;
            IF recItem.GET(Trec50007."Item No.") THEN BEGIN
                IF (recItem."Class of Seeds" = recItem."Class of Seeds"::TL) THEN BEGIN
                    IF CaseNo = CaseNo::Zero THEN
                        ReservationEntry."Lot No." := Trec50008."Marketing Lot No."
                    ELSE
                        IF CaseNo = CaseNo::Seven THEN
                            ReservationEntry."Lot No." := Trec50008."Marketing Lot No."
                        ELSE
                            ReservationEntry."Lot No." := Trec50008."From Bute No.";
                END;
                IF (recItem."Class of Seeds" = recItem."Class of Seeds"::Foundation) THEN BEGIN
                    IF CaseNo = CaseNo::Zero THEN
                        ReservationEntry."Lot No." := Trec50008."Marketing Lot No."
                    ELSE
                        ReservationEntry."Lot No." := Trec50008."From Bute No.";
                END;
                IF (recItem."Class of Seeds" = recItem."Class of Seeds"::Breeder) THEN BEGIN
                    IF CaseNo = CaseNo::Zero THEN
                        ReservationEntry."Lot No." := Trec50008."Marketing Lot No."
                    ELSE
                        ReservationEntry."Lot No." := Trec50008."From Bute No.";
                END;
            END;
        END;
        IF Trec50007."To Stage" <> 'PACKED' THEN
            ReservationEntry."Lot No." := Trec50008."From Bute No.";

        ReservationEntry."Location Code" := rec83."Location Code";
        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
        ReservationEntry."Creation Date" := Trec50007.Date;
        ReservationEntry."Source Type" := 83;
        ReservationEntry."Source ID" := PurchSetup."Process Transfer Template Name";
        ReservationEntry."Source Batch Name" := PurchSetup."Process Transfer Batch Name";
        ReservationEntry."Source Ref. No." := rec83."Line No.";
        ReservationEntry."Created By" := USERID;
        ReservationEntry.Positive := TRUE;
        ReservationEntry."Qty. per Unit of Measure" := rec83."Qty. per Unit of Measure";
        ReservationEntry."Variant Code" := rec83."Variant Code";
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry.INSERT;
        rec83.INSERT;
    end;

    local procedure CheckQuantity(var rec83: Record "Item Journal Line"; var Trec50008: Record "Process Line"; EntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output"; CaseNo: Option Zero,One,Two,Three,Four,Five,Six,Seven,Eight)
    var
        rec27: Record Item;
    begin
        CASE CaseNo OF
            //+ve GQ
            CaseNo::Zero:
                BEGIN
                    //rec83.VALIDATE("Year and State", Trec50008."Year and State");
                    rec83.VALIDATE(Quantity, Trec50008."Good Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Good No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::" ";
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //-ve GQ
            CaseNo::One:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Good Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Good No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::Good;
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //+ve LQ
            CaseNo::Two:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Lint Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Lint No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::" ";
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //-ve LQ
            CaseNo::Three:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Lint Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Lint No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::"Lint Loss";
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //+ve RQ
            CaseNo::Four:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Remenant Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Remenant No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::" ";
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //-ve RQ
            CaseNo::Five:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Remenant Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Remenant No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::"Remenant Loss";
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //-ve PL
            CaseNo::Six:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Process Loss Qty.");
                    rec83."No. of Bags/Pckt" := 0;
                    rec83."Loss Type" := rec83."Loss Type"::"Processing Loss";
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //+ve SQ
            CaseNo::Seven:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Sample Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Sample No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::" ";
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
            //-ve SQ
            CaseNo::Eight:
                BEGIN
                    rec83.VALIDATE(Quantity, Trec50008."Sample Qty.");
                    rec83."No. of Bags/Pckt" := Trec50008."Sample No. of Bags/Pckt";
                    rec83."Loss Type" := rec83."Loss Type"::Good;
                    IF rec27.GET(rec83."Item No.") THEN
                        IF rec27."Unit Cost" <> 0 THEN
                            rec83.VALIDATE("Unit Amount", rec27."Unit Cost");
                END;
        END;
    end;

    local procedure CheckDetailsItemJournal(var Trec83: Record "Item Journal Line"; var rec50007No: Code[20]): Boolean
    var
        T2rec83: Record "Item Journal Line";
    begin
        Trec83.TESTFIELD("Posting Date");
        Trec83.TESTFIELD("Entry Type");
        Trec83.TESTFIELD("Document No.");
        Trec83.TESTFIELD("Item No.");
        Trec83.TESTFIELD("Crop Code");
        Trec83.TESTFIELD("Class of Seeds");
        Trec83.TESTFIELD("Item Type");
        Trec83.TESTFIELD("Variety Code");
        Trec83.TESTFIELD("Location Code");
        Trec83.TESTFIELD(Quantity);
        Trec83.TESTFIELD("Unit of Measure Code", 'KG');
        //Trec83.TESTFIELD("Unit Cost");
        Trec83.TESTFIELD("Variant Code");
        //050520Demo Trec83.TESTFIELD("Bin Code");
        Trec83.TESTFIELD("Document Date");
    end;

    local procedure Post(var Trec50007: Record "Process Header"): Boolean
    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        rec50008: Record "Process Line";
        rec50009: Record "Process Invoice Header";
        rec50010: Record "Process Invoice Line";
    begin
        rec50009.INIT;
        rec50009."Process Transfer Post No." := documentno;
        rec50009.TRANSFERFIELDS(Trec50007);
        rec50009.Status := rec50009.Status::Complete;
        rec50009."Sample Code" := SampleCode;
        rec50009.INSERT;
        rec50008.RESET;
        rec50008.SETCURRENTKEY("Document No.", "Line No.");
        rec50008.SETRANGE("Document No.", Trec50007."No.");
        IF rec50008.FINDSET THEN BEGIN
            REPEAT
                rec50010.INIT;
                rec50010."Post Document No." := rec50009."Process Transfer Post No.";
                rec50010.TRANSFERFIELDS(rec50008);
                rec50010.INSERT;
            UNTIL rec50008.NEXT = 0;
        END;
        EXIT(TRUE);
    end;

    local procedure "------For Bin Warehouse Movement-----"()
    begin
    end;

    local procedure PostWhseJnlLine(ItemJnlLine: Record "Item Journal Line"; OriginalQuantity: Decimal; OriginalQuantityBase: Decimal; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        WITH ItemJnlLine DO BEGIN
            Quantity := OriginalQuantity;
            "Quantity (Base)" := OriginalQuantityBase;
            GetLocation("Location Code");
            IF NOT ("Entry Type" IN ["Entry Type"::Consumption, "Entry Type"::Output]) THEN
                IF Location."Bin Mandatory" THEN
                    IF WMSMgmt.CreateWhseJnlLine(ItemJnlLine, ItemJnlTemplate.Type, WhseJnlLine, FALSE) THEN BEGIN
                        ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, FALSE); //This Pbs kanhaiya
                        IF TempWhseJnlLine2.FINDSET THEN
                            REPEAT
                                WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, FALSE);
                                WhseJnlPostLine.RUN(TempWhseJnlLine2);
                            UNTIL TempWhseJnlLine2.NEXT = 0;
                    END;

            IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
                GetLocation("New Location Code");
                IF Location."Bin Mandatory" THEN
                    IF WMSMgmt.CreateWhseJnlLine(ItemJnlLine, ItemJnlTemplate.Type, WhseJnlLine, TRUE) THEN BEGIN
                        // ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, TRUE); //This PbsKanhaiya
                        IF TempWhseJnlLine2.FINDSET THEN
                            REPEAT
                                WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, TRUE);
                                WhseJnlPostLine.RUN(TempWhseJnlLine2);
                            UNTIL TempWhseJnlLine2.NEXT = 0;
                    END;
            END;
        END;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;

    //blocked
    // local procedure "------For QC Check-----"()
    // begin
    // end;

    // // [Scope('Internal')]
    // procedure CreateQCSample(var Trec50007: Record "Process Header")
    // var
    //     rec27: Record Item;
    //     recCSM: Record "Crop Stage Master";
    //     Trec50008: Record "Process Line";
    //     SampleCodeAllotment: Record "QC Sample Code Allotment";
    //     QCResultDeclaration: Record "QC Result Declaration";
    //     recPurchAndPayableSetup: Record "Purchases & Payables Setup";
    //     "----------------creating sample if already not exists-----------------": Integer;
    //     GotTestingMaster: Record "Got Testing Master";
    //     BTElisaTestingMaster: Record "BT/Elisa Testing Master";
    //     GerminationEvaluation: Record "Germination Evaluation";
    //     PhysicalPurityDetermination: Record "Physical Purity Determination";
    //     MoistureDetermination: Record "Moisture Determination";
    //     VigourTest: Record "Vigour Test";
    //     TempCropStageMaster: Record "Crop Stage Master";
    //     "count": Integer;
    // begin
    //     Trec50008.RESET;
    //     Trec50008.SETCURRENTKEY("Document No.");
    //     Trec50008.SETRANGE("Document No.", Trec50007."No.");
    //     IF Trec50008.FINDSET THEN BEGIN
    //         REPEAT
    //             IF rec27.GET(Trec50007."Item No.") THEN BEGIN
    //                 IF rec27."Skip QC for this Item" = FALSE THEN BEGIN
    //                     IF (rec27."Class of Seeds" = rec27."Class of Seeds"::Foundation) OR (rec27."Class of Seeds" = rec27."Class of Seeds"::TL) THEN BEGIN
    //                         //For Re-grading & RVD Invalidating & Creating Sample Code
    //                         IF (Trec50007.Regrading = TRUE) OR (Trec50007.RVD = TRUE) THEN BEGIN
    //                             InvalidateAndCreateNewQCSample(Trec50007, Trec50008, Trec50007.Season);
    //                         END;
    //                         //Check Sample Code for QC exists or not
    //                         IF (Trec50007.Regrading = FALSE) AND (Trec50007.RVD = FALSE) AND (Trec50008.RVD = FALSE) THEN BEGIN
    //                             SampleCodeAllotment.RESET;
    //                             SampleCodeAllotment.SETCURRENTKEY("Bute No.", Invalid, "Bute No. Year");
    //                             SampleCodeAllotment.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //                             SampleCodeAllotment.SETRANGE(Invalid, FALSE);
    //                             SampleCodeAllotment.SETRANGE("Marketing Lot", FALSE);
    //                             SampleCodeAllotment.SETRANGE("Bute No. Year", Trec50007.Season);
    //                             IF SampleCodeAllotment.FINDFIRST THEN BEGIN
    //                                 SampleCodeAllotment.TESTFIELD("Sample Code");
    //                                 SampleCode := SampleCodeAllotment."Sample Code";
    //                             END ELSE
    //                                 ERROR('Unable to fetch details of Sample Code Allotment for Bute No. %1, Year %2. Please contact youe System Admin.', Trec50008."From Bute No.", DATE2DMY(Trec50007.Date, 3));
    //                         END;

    //                         //Create Samples
    //                         recCSM.RESET;
    //                         recCSM.SETCURRENTKEY("Crop Code", Stage, Type);
    //                         recCSM.SETRANGE("Crop Code", Trec50007."Crop Code");
    //                         recCSM.SETRANGE(Stage, Trec50007."To Stage");
    //                         recCSM.SETRANGE(Type, recCSM.Type::"Process Transfer");
    //                         IF recCSM.FINDFIRST THEN BEGIN
    //                             IF (Trec50007.Regrading = FALSE) AND (Trec50007.RVD = FALSE) THEN BEGIN
    //                                 IF (recCSM.GOT = TRUE) THEN
    //                                     CreateGot(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM.BT = TRUE) THEN
    //                                     CreateBT(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Germination Determination" = TRUE) THEN
    //                                     CreateGD(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Physical Purity Determination" = TRUE) THEN
    //                                     CreatePPD(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Moisture Determination" = TRUE) THEN
    //                                     CreateMD(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Vigour Test" = TRUE) THEN
    //                                     CreateVT(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                             END ELSE BEGIN
    //                                 IF (recCSM."Re-grading With Only GD" = TRUE) AND (recCSM."Re-grading With All STL Tests" = TRUE) THEN
    //                                     ERROR('You cannot tick "Re-grading With Only GD" & "Re-grading With All STL Tests" simultanously at same time.');
    //                                 IF (recCSM."Re-grading With Only GD" = TRUE) AND (recCSM."Re-grading With All STL Tests" = FALSE) THEN
    //                                     CreateGDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                 IF (recCSM."Re-grading With Only GD" = FALSE) AND (recCSM."Re-grading With All STL Tests" = TRUE) THEN BEGIN
    //                                     IF recCSM."Germination Determination" = TRUE THEN
    //                                         CreateGDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Physical Purity Determination" = TRUE THEN
    //                                         CreatePPDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Moisture Determination" = TRUE THEN
    //                                         CreateMDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     //                IF recCSM."Vigour Test" = TRUE THEN //in regarding VT should be generated auto
    //                                     CreateVTForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                 END;
    //                                 IF (recCSM."Re-grading With Only GD" = FALSE) AND (recCSM."Re-grading With All STL Tests" = FALSE) THEN BEGIN
    //                                     IF recCSM."Germination Determination" = TRUE THEN
    //                                         CreateGDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Physical Purity Determination" = TRUE THEN
    //                                         CreatePPDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Moisture Determination" = TRUE THEN
    //                                         CreateMDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     //                IF recCSM."Vigour Test" = TRUE THEN //in regarding VT should be generated auto
    //                                     CreateVTForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                 END;
    //                             END;
    //                         END;

    //                         //NAKUL QC SIGNOFF CHANGES 11022021
    //                         //          //creating sample if already not exists
    //                         //          recCSM.RESET;
    //                         //          recCSM.SETCURRENTKEY("Crop Code",Stage,Type);
    //                         //          recCSM.SETRANGE("Crop Code",Trec50007."Crop Code");
    //                         //          recCSM.SETRANGE(Stage,Trec50007."To Stage");
    //                         //          recCSM.SETRANGE(Type,recCSM.Type::"Process Transfer");
    //                         //          IF recCSM.FINDFIRST THEN BEGIN
    //                         //            FOR count := recCSM.Sequence DOWNTO 1 DO BEGIN
    //                         //              TempCropStageMaster.RESET;
    //                         //              TempCropStageMaster.SETCURRENTKEY("Crop Code",Sequence,Type);
    //                         //              TempCropStageMaster.SETRANGE("Crop Code",recCSM."Crop Code");
    //                         //              TempCropStageMaster.SETRANGE(Sequence,count);
    //                         //              TempCropStageMaster.SETRANGE(Type,recCSM.Type);
    //                         //              IF TempCropStageMaster.FINDFIRST THEN BEGIN
    //                         //                IF TempCropStageMaster.GOT = TRUE THEN BEGIN
    //                         //                  GotTestingMaster.RESET;
    //                         //                  GotTestingMaster.SETCURRENTKEY("Bute No.");
    //                         //                  GotTestingMaster.SETRANGE("Bute No.",Trec50008."From Bute No.");
    //                         //                  GotTestingMaster.SETRANGE("Sample Code",SampleCode);
    //                         //                  GotTestingMaster.SETRANGE("Temp Season Code",Trec50007.Season);
    //                         //                  IF NOT GotTestingMaster.FINDFIRST THEN
    //                         //                    CreateGot(Trec50007,Trec50008,rec27."Class of Seeds");
    //                         //                END;
    //                         //                IF TempCropStageMaster.BT = TRUE THEN BEGIN
    //                         //                  BTElisaTestingMaster.RESET;
    //                         //                  BTElisaTestingMaster.SETCURRENTKEY("Bute No.");
    //                         //                  BTElisaTestingMaster.SETRANGE("Bute No.",Trec50008."From Bute No.");
    //                         //                  BTElisaTestingMaster.SETRANGE("Sample Code",SampleCode);
    //                         //                  BTElisaTestingMaster.SETRANGE("Temp Season Code",Trec50007.Season);
    //                         //                  IF NOT BTElisaTestingMaster.FINDFIRST THEN
    //                         //                    CreateBT(Trec50007,Trec50008,rec27."Class of Seeds");
    //                         //                END;
    //                         //                IF TempCropStageMaster."Germination Determination" = TRUE THEN BEGIN
    //                         //                  GerminationEvaluation.RESET;
    //                         //                  GerminationEvaluation.SETCURRENTKEY("Bute No.");
    //                         //                  GerminationEvaluation.SETRANGE("Bute No.",Trec50008."From Bute No.");
    //                         //                  GerminationEvaluation.SETRANGE("Sample Code",SampleCode);
    //                         //                  GerminationEvaluation.SETRANGE("Temp Season Code",Trec50007.Season);
    //                         //                  IF NOT GerminationEvaluation.FINDFIRST THEN
    //                         //                    CreateGD(Trec50007,Trec50008,rec27."Class of Seeds");
    //                         //                END;
    //                         //                IF TempCropStageMaster."Physical Purity Determination" = TRUE THEN BEGIN
    //                         //                  PhysicalPurityDetermination.RESET;
    //                         //                  PhysicalPurityDetermination.SETCURRENTKEY("Bute No.");
    //                         //                  PhysicalPurityDetermination.SETRANGE("Bute No.",Trec50008."From Bute No.");
    //                         //                  PhysicalPurityDetermination.SETRANGE("Sample Code",SampleCode);
    //                         //                  PhysicalPurityDetermination.SETRANGE("Temp Season Code",Trec50007.Season);
    //                         //                  IF NOT PhysicalPurityDetermination.FINDFIRST THEN
    //                         //                    CreatePPD(Trec50007,Trec50008,rec27."Class of Seeds");
    //                         //                END;
    //                         //                IF TempCropStageMaster."Moisture Determination" = TRUE THEN BEGIN
    //                         //                  MoistureDetermination.RESET;
    //                         //                  MoistureDetermination.SETCURRENTKEY("Bute No.");
    //                         //                  MoistureDetermination.SETRANGE("Bute No.",Trec50008."From Bute No.");
    //                         //                  MoistureDetermination.SETRANGE("Sample Code",SampleCode);
    //                         //                  MoistureDetermination.SETRANGE("Temp Season Code",Trec50007.Season);
    //                         //                  IF NOT MoistureDetermination.FINDFIRST THEN
    //                         //                    CreateMD(Trec50007,Trec50008,rec27."Class of Seeds");
    //                         //                END;
    //                         //                IF TempCropStageMaster."Vigour Test" = TRUE THEN BEGIN
    //                         //                  VigourTest.RESET;
    //                         //                  VigourTest.SETCURRENTKEY("Bute No.");
    //                         //                  VigourTest.SETRANGE("Bute No.",Trec50008."From Bute No.");
    //                         //                  VigourTest.SETRANGE("Sample Code",SampleCode);
    //                         //                  VigourTest.SETRANGE("Temp Season Code",Trec50007.Season);
    //                         //                  IF NOT VigourTest.FINDFIRST THEN
    //                         //                    CreateVT(Trec50007,Trec50008,rec27."Class of Seeds");
    //                         //                END;
    //                         //              END;
    //                         //            END;
    //                         //          END;

    //                         //Create QC Result Sample
    //                         QCResultDeclaration.RESET;
    //                         QCResultDeclaration.SETCURRENTKEY("Lab Code", "Temp Bute No.", "Temp Season Code", Invalid);
    //                         QCResultDeclaration.SETRANGE("Lab Code", SampleCode);
    //                         QCResultDeclaration.SETRANGE("Temp Bute No.", Trec50008."From Bute No.");
    //                         QCResultDeclaration.SETRANGE("Temp Season Code", Trec50007.Season);
    //                         QCResultDeclaration.SETRANGE(Invalid, FALSE);
    //                         IF NOT QCResultDeclaration.FINDFIRST THEN BEGIN
    //                             QCResultDeclaration.RESET;
    //                             QCResultDeclaration.INIT;
    //                             recUL.RESET;
    //                             recUL.SETCURRENTKEY("User ID");
    //                             recUL.SETRANGE("User ID", USERID);
    //                             recUL.SETRANGE("QC Result Declaration", TRUE);
    //                             IF recUL.FINDFIRST THEN BEGIN
    //                                 IF recPurchAndPayableSetup.GET THEN BEGIN
    //                                     recPurchAndPayableSetup.TESTFIELD("QC Result Declara. No.");
    //                                     QCResultDeclaration."No." := NoSeriesMgt.GetNextNo(recPurchAndPayableSetup."QC Result Declara. No.", Trec50007.Date, TRUE);//This PBs Kanhaiya
    //                                 END ELSE
    //                                     ERROR('Purchase & Payable Setup %1 ''. It cannot be Blank.', recPurchAndPayableSetup.FIELDCAPTION("QC Result Declara. No."));
    //                             END ELSE
    //                                 ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
    //                             QCResultDeclaration.VALIDATE("Lab Code", SampleCode);
    //                             QCResultDeclaration.VALIDATE("Temp Season Code", Trec50007.Season);
    //                             QCResultDeclaration.VALIDATE("Temp Document No.", documentno);
    //                             QCResultDeclaration.VALIDATE("Temp Variant Code", Trec50007."To Stage");
    //                             QCResultDeclaration.VALIDATE("Temp Bute No.", Trec50008."From Bute No.");
    //                             QCResultDeclaration.VALIDATE("Process Transfer Entry", TRUE);
    //                             QCResultDeclaration."Prefix No." := Trec50008."Prefix No.";
    //                             QCResultDeclaration.INSERT(TRUE);
    //                         END;
    //                     END;
    //                 END;
    //             END;
    //         UNTIL Trec50008.NEXT = 0;
    //     END;
    // end;

    // // [Scope('Internal')]
    // procedure InvalidateAndCreateNewQCSample(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; SeasonCode: Code[20])
    // var
    //     SampleCodeAllotment: Record "QC Sample Code Allotment";
    //     Var_OldButeNoYear: Code[10];
    //     Var_OldSampleCodeYear: Code[10];
    //     RVDQCSampleCode: Record "RVD QC Sample Code";
    //     RegradingQCSampleCode: Record "Regrading QC Sample Code";
    //     Var_OldFromButteNo: Code[10];
    //     GotTestingMaster: Record "Got Testing Master";
    //     RecGD: Record "Germination Evaluation";
    // begin
    //     IF Trec50007.Regrading = TRUE THEN BEGIN
    //         //Check Sample Code for QC exists or not
    //         CLEAR(SampleCodeAllotment);
    //         SampleCodeAllotment.RESET;
    //         SampleCodeAllotment.SETCURRENTKEY("Bute No.", Invalid, "Bute No. Year");
    //         SampleCodeAllotment.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         SampleCodeAllotment.SETRANGE(Invalid, FALSE);
    //         SampleCodeAllotment.SETRANGE("Marketing Lot", FALSE);
    //         SampleCodeAllotment.SETRANGE("Bute No. Year", SeasonCode);
    //         SampleCodeAllotment.SETRANGE("Prefix No", Trec50008."Prefix No.");//LK-16-08-2021
    //         IF SampleCodeAllotment.FINDSET THEN BEGIN
    //             REPEAT
    //                 SampleCodeAllotment.TESTFIELD("Sample Code");
    //                 SampleCodeAllotment.Invalid := TRUE;
    //                 SampleCodeAllotment.MODIFY;
    //                 Trec50008.CALCFIELDS("Location Code");
    //                 Trec50008.CALCFIELDS("Season Code");
    //                 InvalidatingQCSampleEntriesOfSTL(SampleCodeAllotment."Sample Code", Trec50007.Season, Trec50008."From Bute No.", Trec50007."To Stage", Trec50007, SampleCodeAllotment."From Butte No", Trec50008);
    //                 InvalidatingQCSampleEntriesOfGOTandBTElisa(SampleCodeAllotment."Sample Code", Trec50008."New QC Sample Code", Trec50008."Location Code", Trec50007."No.", Trec50007.Season, Trec50008."From Bute No.", Trec50007."To Stage", Trec50007
    //                 , SampleCodeAllotment."From Butte No", Trec50008);
    //                 Var_OldButeNoYear := SampleCodeAllotment."Bute No. Year";
    //                 Var_OldSampleCodeYear := SampleCodeAllotment."Sample Code Year";
    //             UNTIL SampleCodeAllotment.NEXT = 0;
    //             //Check Sample Code for QC exists or not
    //             SampleCodeAllotment.RESET;
    //             SampleCodeAllotment.INIT;
    //             SampleCodeAllotment.VALIDATE("Bute No.", Trec50008."From Bute No.");
    //             SampleCodeAllotment.VALIDATE("Sample Code", Trec50008."New QC Sample Code");
    //             SampleCodeAllotment.VALIDATE("Bute No. Year", Var_OldButeNoYear);
    //             SampleCodeAllotment.VALIDATE("Sample Code Year", Var_OldSampleCodeYear);
    //             SampleCodeAllotment."Prefix No" := Trec50008."Prefix No.";//LK-16-08-21
    //             SampleCodeAllotment.VALIDATE(Invalid, FALSE);
    //             SampleCodeAllotment.INSERT(TRUE);
    //             SampleCode := Trec50008."New QC Sample Code";
    //         END ELSE BEGIN
    //             RegradingQCSampleCode.RESET;
    //             RegradingQCSampleCode.SETCURRENTKEY("Bute No.", "Bute No. Year", "Serial No.");
    //             RegradingQCSampleCode.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //             RegradingQCSampleCode.SETRANGE("Bute No. Year", SeasonCode);
    //             RegradingQCSampleCode.SETRANGE(Used, FALSE);
    //             RegradingQCSampleCode.SETASCENDING("Serial No.", TRUE);
    //             RegradingQCSampleCode.FINDFIRST;
    //             RegradingQCSampleCode.TESTFIELD(Used, FALSE);
    //             RegradingQCSampleCode.TESTFIELD("QC Sample Code");
    //             //Check Sample Code for QC exists or not
    //             SampleCodeAllotment.RESET;
    //             SampleCodeAllotment.INIT;
    //             SampleCodeAllotment.VALIDATE("Bute No.", Trec50008."From Bute No.");
    //             SampleCodeAllotment.VALIDATE("Sample Code", Trec50008."New QC Sample Code");
    //             SampleCodeAllotment.VALIDATE("Bute No. Year", Trec50007.Season);
    //             SampleCodeAllotment.VALIDATE("Sample Code Year", RegradingQCSampleCode."QC Sample Code");
    //             SampleCodeAllotment."Prefix No" := Trec50008."Prefix No.";//LK-16-08-21
    //             SampleCodeAllotment.VALIDATE(Invalid, FALSE);
    //             SampleCodeAllotment.INSERT(TRUE);
    //             SampleCode := Trec50008."New QC Sample Code";
    //             RecGD.RESET;
    //             RecGD.SETRANGE("Prefix No.", Trec50008."Prefix No.");
    //             RecGD.SETRANGE(Invalid, FALSE);
    //             RecGD.SETRANGE(Posted, TRUE);
    //             RecGD.FINDFIRST;
    //             InvalidatingQCSampleEntriesOfSTL(RecGD."Sample Code", Trec50007.Season, Trec50008."From Bute No.", Trec50007."To Stage", Trec50007, SampleCodeAllotment."From Butte No", Trec50008);
    //             GotTestingMaster.RESET;
    //             GotTestingMaster.SETRANGE("Prefix No.", Trec50008."Prefix No.");
    //             GotTestingMaster.SETRANGE(Invalid, FALSE);
    //             GotTestingMaster.SETRANGE(Posted, TRUE);
    //             GotTestingMaster.FINDFIRST;
    //             Trec50008.CALCFIELDS("Season Code", "Location Code");
    //             InvalidatingQCSampleEntriesOfGOTandBTElisa(GotTestingMaster."Sample Code", Trec50008."New QC Sample Code", Trec50008."Location Code", Trec50007."No.", Trec50007.Season, Trec50008."From Bute No.", Trec50007."To Stage", Trec50007
    //             , SampleCodeAllotment."From Butte No", Trec50008);
    //         END;
    //     END;
    //     IF Trec50007.RVD = TRUE THEN BEGIN
    //         //Check Sample Code for QC exists or not
    //         CLEAR(SampleCodeAllotment);
    //         SampleCodeAllotment.RESET;
    //         SampleCodeAllotment.SETCURRENTKEY("Bute No.", Invalid, "Bute No. Year", "Marketing Lot");
    //         SampleCodeAllotment.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         SampleCodeAllotment.SETRANGE(Invalid, FALSE);
    //         SampleCodeAllotment.SETRANGE("Bute No. Year", SeasonCode);
    //         SampleCodeAllotment.SETRANGE("Marketing Lot", TRUE);
    //         IF SampleCodeAllotment.FINDFIRST THEN BEGIN
    //             REPEAT
    //                 SampleCodeAllotment.TESTFIELD("Sample Code");
    //                 SampleCodeAllotment.TESTFIELD("From Butte No");
    //                 SampleCodeAllotment.Invalid := TRUE;
    //                 SampleCodeAllotment.MODIFY;
    //                 Trec50008.CALCFIELDS("Location Code");
    //                 InvalidatingQCSampleEntriesOfGOTandBTElisa(SampleCodeAllotment."Sample Code", Trec50008."New QC Sample Code", Trec50008."Location Code", Trec50007."No.", Trec50007.Season, Trec50008."From Bute No.", Trec50007."To Stage", Trec50007
    //                 , SampleCodeAllotment."From Butte No", Trec50008);
    //                 //InvalidatingQCSampleEntriesOfSTL(SampleCodeAllotment."Sample Code",Trec50007.Season,Trec50008."From Bute No.",Trec50007."To Stage",Trec50007,SampleCodeAllotment."From Butte No");
    //                 Var_OldButeNoYear := SampleCodeAllotment."Bute No. Year";
    //                 Var_OldSampleCodeYear := SampleCodeAllotment."Sample Code Year";
    //                 Var_OldFromButteNo := SampleCodeAllotment."From Butte No";//LK
    //             UNTIL SampleCodeAllotment.NEXT = 0;
    //             //Check Sample Code for QC exists or not
    //             CLEAR(SampleCodeAllotment);
    //             SampleCodeAllotment.RESET;
    //             SampleCodeAllotment.INIT;
    //             SampleCodeAllotment.VALIDATE("Bute No.", Trec50008."From Bute No.");
    //             SampleCodeAllotment.VALIDATE("Sample Code", Trec50008."New QC Sample Code");
    //             SampleCodeAllotment.VALIDATE("Bute No. Year", Var_OldButeNoYear);
    //             SampleCodeAllotment.VALIDATE("Sample Code Year", Var_OldSampleCodeYear);
    //             SampleCodeAllotment.VALIDATE(Invalid, FALSE);
    //             SampleCodeAllotment.VALIDATE("Marketing Lot", TRUE);
    //             SampleCodeAllotment."From Butte No" := Var_OldFromButteNo;
    //             SampleCodeAllotment.INSERT(TRUE);
    //             SampleCode := Trec50008."New QC Sample Code";
    //         END ELSE BEGIN
    //             CLEAR(SampleCodeAllotment);
    //             CLEAR(RVDQCSampleCode);
    //             RVDQCSampleCode.RESET;
    //             RVDQCSampleCode.SETCURRENTKEY("Bute No.", "Bute No. Year", "Document No.", "Serial No.");
    //             RVDQCSampleCode.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //             RVDQCSampleCode.SETRANGE("Bute No. Year", SeasonCode);
    //             RVDQCSampleCode.SETRANGE("Document No.", Trec50008."Document No.");
    //             RVDQCSampleCode.SETASCENDING("Serial No.", TRUE);
    //             RVDQCSampleCode.FINDLAST;
    //             RVDQCSampleCode.TESTFIELD(Used, FALSE);
    //             RVDQCSampleCode.TESTFIELD("QC Sample Code");
    //             //Check Sample Code for QC exists or not
    //             SampleCodeAllotment.RESET;
    //             SampleCodeAllotment.INIT;
    //             SampleCodeAllotment.VALIDATE("Bute No.", Trec50008."From Bute No.");
    //             SampleCodeAllotment.VALIDATE("Sample Code", Trec50008."New QC Sample Code");
    //             SampleCodeAllotment.VALIDATE("Bute No. Year", SeasonCode);
    //             SampleCodeAllotment.VALIDATE("Sample Code Year", RVDQCSampleCode."QC Sample Code");
    //             SampleCodeAllotment.VALIDATE(Invalid, FALSE);
    //             SampleCodeAllotment.VALIDATE("Marketing Lot", TRUE);
    //             SampleCodeAllotment."From Butte No" := RVDQCSampleCode."Bute No.";
    //             SampleCodeAllotment.INSERT(TRUE);
    //             SampleCode := Trec50008."New QC Sample Code";
    //             Trec50008.CALCFIELDS("Location Code");
    //             Trec50008.CALCFIELDS("Season Code");
    //             InvalidatingQCSampleEntriesOfGOTandBTElisa(SampleCodeAllotment."Sample Code", Trec50008."New QC Sample Code", Trec50008."Location Code", Trec50007."No.", Trec50007.Season, Trec50008."From Bute No.", Trec50007."To Stage", Trec50007
    //             , SampleCodeAllotment."From Butte No", Trec50008);
    //             //    InvalidatingQCSampleEntriesOfSTL(SampleCodeAllotment."Sample Code",Trec50007.Season,Trec50008."From Bute No.",Trec50007."To Stage",Trec50007,SampleCodeAllotment."From Butte No");
    //         END;
    //     END;
    // end;

    // // [Scope('Internal')]
    // procedure InvalidatingQCSampleEntriesOfGOTandBTElisa(InvalidSampleCode: Code[20]; NewQCSampleCode: Code[20]; LocationCode: Code[20]; Var_documentno: Code[20]; SeasonCode: Code[20]; LotNo: Code[20]; VariantCode: Code[20]; Rec50007: Record "Process Header"; FromButteNo: Code[20]; Rec50008: Record "Process Line")
    // var
    //     recGOT: Record "Got Testing Master";
    //     TrecGOT: Record "Got Testing Master";
    //     GotDocumentNo: Code[20];
    //     GOTDateofResultDeclaration: Date;
    //     recBTElisa: Record "BT/Elisa Testing Master";
    //     TrecBTElisa: Record "BT/Elisa Testing Master";
    //     BTElisaDocumentNo: Code[20];
    //     BTElisaDateofResultDeclaration: Date;
    //     QCResultDeclaration: Record "QC Result Declaration";
    //     BlendHeader: Record "Blend Header";
    //     RIBHeader: Record "RIB Header";
    // begin
    //     //recGot
    //     recGOT.RESET;
    //     recGOT.SETCURRENTKEY("Sample Code", Invalid);
    //     recGOT.SETRANGE("Sample Code", InvalidSampleCode);
    //     IF Rec50007.Regrading THEN
    //         recGOT.SETRANGE("Bute No.", LotNo)
    //     ELSE
    //         IF Rec50007.RVD THEN
    //             recGOT.SETRANGE("Bute No.", FromButteNo);
    //     recGOT.SETRANGE("Temp Season Code", SeasonCode);
    //     // recGOT.SETRANGE("Stage Code",VariantCode);
    //     recGOT.SETRANGE(Invalid, FALSE);
    //     recGOT.SETRANGE(Posted, TRUE);
    //     IF recGOT.FINDSET THEN BEGIN
    //         REPEAT
    //             recGOT.VALIDATE(Invalid, TRUE);
    //             recGOT.VALIDATE("Invalid User Id", USERID);
    //             GOTDateofResultDeclaration := recGOT."Date of Result Declaration";
    //             recGOT.MODIFY;
    //         UNTIL recGOT.NEXT = 0;
    //     END;
    //     //Create New Sample
    //     recGOT.RESET;
    //     recGOT.SETCURRENTKEY("Sample Code", "Date of Result Declaration", Invalid, "Invalid User Id");
    //     IF Rec50007.Regrading THEN BEGIN
    //         recGOT.SETRANGE("Sample Code", InvalidSampleCode);
    //         recGOT.SETRANGE("Bute No.", LotNo);
    //         recGOT.SETRANGE("Date of Result Declaration", GOTDateofResultDeclaration);
    //         recGOT.SETRANGE("Invalid User Id", USERID);
    //     END
    //     ELSE
    //         IF Rec50007.RVD THEN
    //             recGOT.SETRANGE("Bute No.", FromButteNo);
    //     recGOT.SETRANGE("Temp Season Code", SeasonCode);
    //     // recGOT.SETRANGE("Stage Code",VariantCode);
    //     recGOT.SETRANGE(Invalid, TRUE);
    //     recGOT.SETRANGE(Posted, TRUE);
    //     IF recGOT.FINDFIRST THEN BEGIN
    //         IF Rec50007.RVD THEN
    //             recGOT."RVD Counter" += 1;
    //         IF Rec50007.Regrading THEN
    //             recGOT."Regrading Counter" += 1;
    //         recGOT.MODIFY;

    //         TrecGOT.INIT;
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         recUL.SETRANGE("Got Testing Master", TRUE);
    //         recUL.SETRANGE("Location Code", LocationCode);
    //         IF recUL.FINDFIRST THEN BEGIN
    //             IF recLoc.GET(LocationCode) THEN BEGIN
    //                 recLoc.TESTFIELD("Got Series");
    //                 GotDocumentNo := NoSeriesMgt.GetNextNo(recLoc."Got Series", TODAY, TRUE);//This PBS kanhaiya
    //             END ELSE
    //                 ERROR(Text002, LocationCode, recLoc.FIELDCAPTION("Got Series"));
    //         END ELSE
    //             ERROR(ContactAdminText003);
    //         TrecGOT."No." := GotDocumentNo;
    //         TrecGOT.TRANSFERFIELDS(recGOT);
    //         TrecGOT."No." := GotDocumentNo;
    //         TrecGOT."Bute No." := LotNo;
    //         TrecGOT."Sample Code" := NewQCSampleCode;
    //         TrecGOT.VALIDATE("Item No.", Rec50007."Item No.");
    //         IF TrecGOT."Document No." = '' THEN
    //             TrecGOT."Document No." := Var_documentno;
    //         TrecGOT.Invalid := FALSE;
    //         TrecGOT."Invalid User Id" := '';
    //         TrecGOT.TESTFIELD("No.");
    //         TrecGOT.TESTFIELD("Sample Code");
    //         TrecGOT.TESTFIELD("Crop Code");
    //         TrecGOT.TESTFIELD("Document No.");
    //         TrecGOT.TESTFIELD("Item No.");
    //         TrecGOT.TESTFIELD("Bute No.");
    //         TrecGOT.TESTFIELD("Arrival Qty.");
    //         TrecGOT.TESTFIELD("Source Type");
    //         TrecGOT.TESTFIELD("Stage Code");
    //         IF (Rec50007.RVD) OR (Rec50007.Regrading) THEN BEGIN
    //             BlendHeader.RESET;
    //             BlendHeader.SETCURRENTKEY(Posted, "New Bute No.");
    //             BlendHeader.SETRANGE(Posted, TRUE);
    //             BlendHeader.SETRANGE("New Bute No.", FromButteNo);
    //             BlendHeader.SETRANGE("Season Code", Rec50007.Season);
    //             IF BlendHeader.FINDFIRST THEN BEGIN
    //                 // BlendHeader.CALCFIELDS("GOT Avg Per");
    //                 BlendHeader.TESTFIELD("GOT Avg Per");
    //                 TrecGOT."Genetic Pure Plants %" := BlendHeader."GOT Avg Per";
    //             END ELSE BEGIN
    //                 RIBHeader.RESET;
    //                 RIBHeader.SETCURRENTKEY(Posted, "New Bute No.");
    //                 RIBHeader.SETRANGE(Posted, TRUE);
    //                 RIBHeader.SETRANGE("New Bute No.", FromButteNo);
    //                 RIBHeader.SETRANGE("Season Code", Rec50007.Season);
    //                 IF RIBHeader.FINDFIRST THEN BEGIN
    //                     // BlendHeader.CALCFIELDS("GOT Avg Per");
    //                     RIBHeader.TESTFIELD("GOT Avg Per");
    //                     TrecGOT."Genetic Pure Plants %" := RIBHeader."GOT Avg Per";
    //                 END;
    //             END
    //         END;
    //         TrecGOT."Prefix No." := Rec50008."Prefix No.";
    //         IF Rec50007.RVD THEN
    //             TrecGOT."Copy From" := recGOT."Copy From"::RVD;
    //         IF Rec50007.Regrading THEN
    //             TrecGOT."Copy From" := recGOT."Copy From"::Regrading;
    //         TrecGOT.INSERT;
    //         //LK
    //         CLEAR(QCResultDeclaration);
    //         QCResultDeclaration.RESET;
    //         QCResultDeclaration.SETCURRENTKEY("Temp Item No.", "Lab Code", "Temp Season Code", "Temp Bute No.", Invalid);
    //         QCResultDeclaration.SETRANGE("Temp Item No.", Rec50008."Item No.");
    //         QCResultDeclaration.SETRANGE("Lab Code", NewQCSampleCode);
    //         QCResultDeclaration.SETRANGE("Temp Season Code", TrecGOT."Temp Season Code");
    //         QCResultDeclaration.SETRANGE("Temp Bute No.", LotNo);
    //         QCResultDeclaration.SETRANGE(Invalid, FALSE);
    //         QCResultDeclaration.SETRANGE(Posted, FALSE);
    //         QCResultDeclaration.SETRANGE("Prefix No.", Rec50008."Prefix No.");
    //         IF QCResultDeclaration.FINDFIRST THEN BEGIN
    //             QCResultDeclaration.VALIDATE("Temp GOT Result", TrecGOT.Result);
    //             QCResultDeclaration.VALIDATE("Temp Got Test Date", TrecGOT."Date of Result Declaration");
    //             QCResultDeclaration.VALIDATE("Temp Got test User", TrecGOT."Result User Id");
    //             QCResultDeclaration.VALIDATE("Temp Item No.", TrecGOT."Item No.");
    //             QCResultDeclaration."Prefix No." := TrecGOT."Prefix No.";
    //             QCResultDeclaration.MODIFY(TRUE);
    //         END ELSE
    //             IF NOT QCResultDeclaration.FINDFIRST THEN BEGIN
    //                 QCResultDeclaration.VALIDATE("Lab Code", NewQCSampleCode);
    //                 QCResultDeclaration.VALIDATE("Temp Season Code", Rec50007.Season);
    //                 QCResultDeclaration.VALIDATE("Temp Document No.", documentno);
    //                 QCResultDeclaration.VALIDATE("Temp Variant Code", Rec50007."To Stage");
    //                 QCResultDeclaration.VALIDATE("Temp Bute No.", LotNo);
    //                 QCResultDeclaration.VALIDATE("Process Transfer Entry", TRUE);
    //                 QCResultDeclaration.VALIDATE("Temp GOT Result", TrecGOT.Result);
    //                 QCResultDeclaration.VALIDATE("Temp Got Test Date", TrecGOT."Date of Result Declaration");
    //                 QCResultDeclaration.VALIDATE("Temp Got test User", TrecGOT."Result User Id");
    //                 QCResultDeclaration.VALIDATE("Temp Item No.", TrecGOT."Item No.");
    //                 QCResultDeclaration."Prefix No." := Rec50008."Prefix No.";
    //                 QCResultDeclaration.INSERT(TRUE);
    //             END;
    //         //LK
    //     END;

    //     //recBT/Elisa
    //     Rec50007.TESTFIELD("Crop Code");
    //     IF Rec50007."Crop Code" = 'CT' THEN BEGIN //LK-26=08-21- As per smbhaji BT code should run Only if the crop code is cotton hard codede
    //         recBTElisa.RESET;
    //         recBTElisa.SETCURRENTKEY("Sample Code", Invalid);
    //         IF Rec50007.Regrading THEN BEGIN
    //             recBTElisa.SETRANGE("Sample Code", InvalidSampleCode);
    //             recBTElisa.SETRANGE("Bute No.", LotNo);
    //         END
    //         ELSE
    //             IF Rec50007.RVD THEN
    //                 recBTElisa.SETRANGE("Bute No.", FromButteNo);
    //         // recBTElisa.SETRANGE("Stage Code",VariantCode);
    //         recBTElisa.SETRANGE("Temp Season Code", SeasonCode);
    //         recBTElisa.SETRANGE(Invalid, FALSE);
    //         recBTElisa.SETRANGE(Posted, TRUE);
    //         IF recBTElisa.FINDSET THEN BEGIN
    //             REPEAT
    //                 recBTElisa.VALIDATE(Invalid, TRUE);
    //                 recBTElisa.VALIDATE("Invalid User Id", USERID);
    //                 BTElisaDateofResultDeclaration := recBTElisa."Date of Testing";
    //                 recBTElisa.MODIFY;
    //             UNTIL recBTElisa.NEXT = 0;
    //         END;
    //         //Create New Sample
    //         recBTElisa.RESET;
    //         recBTElisa.SETCURRENTKEY("Sample Code", "Date of Testing", Invalid, "Invalid User Id");
    //         IF Rec50007.Regrading THEN BEGIN
    //             recBTElisa.SETRANGE("Bute No.", LotNo);
    //             recBTElisa.SETRANGE("Sample Code", InvalidSampleCode);
    //             recBTElisa.SETRANGE("Date of Testing", BTElisaDateofResultDeclaration);
    //             recBTElisa.SETRANGE("Invalid User Id", USERID);
    //         END
    //         ELSE
    //             IF Rec50007.RVD THEN
    //                 recBTElisa.SETRANGE("Bute No.", FromButteNo);
    //         recBTElisa.SETRANGE("Temp Season Code", SeasonCode);
    //         // recBTElisa.SETRANGE("Stage Code",VariantCode);
    //         recBTElisa.SETRANGE(Invalid, TRUE);
    //         recBTElisa.SETRANGE(Posted, TRUE);
    //         IF recBTElisa.FINDFIRST THEN BEGIN
    //             IF Rec50007.RVD THEN
    //                 recBTElisa."RVD Counter" += 1;
    //             IF Rec50007.Regrading THEN
    //                 recBTElisa."Regrading Counter" += 1;
    //             recBTElisa.MODIFY;
    //             TrecBTElisa.INIT;
    //             recUL.RESET;
    //             recUL.SETCURRENTKEY("User ID");
    //             recUL.SETRANGE("User ID", USERID);
    //             recUL.SETRANGE("BT Testing Master", TRUE);
    //             recUL.SETRANGE("Location Code", LocationCode);
    //             IF recUL.FINDFIRST THEN BEGIN
    //                 IF recLoc.GET(LocationCode) THEN BEGIN
    //                     recLoc.TESTFIELD("BT Series");
    //                     BTElisaDocumentNo := NoSeriesMgt.GetNextNo(recLoc."BT Series", TODAY, TRUE);//This PBS Kanhaiya
    //                 END ELSE
    //                     ERROR(Text002, LocationCode, recLoc.FIELDCAPTION("BT Series"));
    //             END ELSE
    //                 ERROR(ContactAdminText003);
    //             TrecBTElisa."No." := BTElisaDocumentNo;
    //             TrecBTElisa.TRANSFERFIELDS(recBTElisa);
    //             TrecBTElisa."No." := BTElisaDocumentNo;
    //             TrecBTElisa."Sample Code" := NewQCSampleCode;
    //             IF TrecBTElisa."Document No." = '' THEN
    //                 TrecBTElisa."Document No." := Var_documentno;
    //             TrecBTElisa."Bute No." := LotNo;
    //             TrecBTElisa.VALIDATE("Item No.", Rec50007."Item No.");
    //             TrecBTElisa.Invalid := FALSE;
    //             TrecBTElisa."Invalid User Id" := '';
    //             TrecBTElisa.TESTFIELD("No.");
    //             TrecBTElisa.TESTFIELD("Sample Code");
    //             TrecBTElisa.TESTFIELD("Crop Code");
    //             TrecBTElisa.TESTFIELD("Document No.");
    //             TrecBTElisa.TESTFIELD("Item No.");
    //             TrecBTElisa.TESTFIELD("Bute No.");
    //             TrecBTElisa.TESTFIELD("Qty. of Arrival");
    //             TrecBTElisa.TESTFIELD("Source Type");
    //             TrecBTElisa.TESTFIELD("Stage Code");
    //             IF (Rec50007.RVD) OR (Rec50007.Regrading) THEN BEGIN
    //                 BlendHeader.RESET;
    //                 BlendHeader.SETCURRENTKEY(Posted, "New Bute No.");
    //                 BlendHeader.SETRANGE(Posted, TRUE);
    //                 BlendHeader.SETRANGE("New Bute No.", FromButteNo);
    //                 BlendHeader.SETRANGE("Season Code", Rec50007.Season);
    //                 IF BlendHeader.FINDFIRST THEN BEGIN
    //                     IF (TrecBTElisa."Positive For CRY 1AC %" > 0) THEN
    //                         BlendHeader.TESTFIELD("BT Cry 1 Avg Per");
    //                     IF (TrecBTElisa."Positive For CRY 2AB %" > 0) THEN
    //                         BlendHeader.TESTFIELD("BT Cry 2 Avg Per");
    //                     TrecBTElisa."Positive For CRY 1AC %" := BlendHeader."BT Cry 1 Avg Per";
    //                     TrecBTElisa."Positive For CRY 2AB %" := BlendHeader."BT Cry 2 Avg Per";
    //                 END ELSE BEGIN
    //                     RIBHeader.RESET;
    //                     RIBHeader.SETCURRENTKEY(Posted, "New Bute No.");
    //                     RIBHeader.SETRANGE(Posted, TRUE);
    //                     RIBHeader.SETRANGE("New Bute No.", FromButteNo);
    //                     RIBHeader.SETRANGE("Season Code", Rec50007.Season);
    //                     IF RIBHeader.FINDFIRST THEN BEGIN
    //                         IF (TrecBTElisa."Positive For CRY 1AC %" > 0) THEN
    //                             RIBHeader.TESTFIELD("BT Cry 1 Avg Per");
    //                         IF (TrecBTElisa."Positive For CRY 2AB %" > 0) THEN
    //                             RIBHeader.TESTFIELD("BT Cry 2 Avg Per");
    //                         TrecBTElisa."Positive For CRY 1AC %" := RIBHeader."BT Cry 1 Avg Per";
    //                         TrecBTElisa."Positive For CRY 2AB %" := RIBHeader."BT Cry 2 Avg Per";
    //                     END;
    //                 END
    //             END;
    //             TrecBTElisa."Prefix No." := Rec50008."Prefix No.";
    //             IF Rec50007.RVD THEN
    //                 TrecBTElisa."Copy From" := TrecBTElisa."Copy From"::RVD;
    //             IF Rec50007.Regrading THEN
    //                 TrecBTElisa."Copy From" := TrecBTElisa."Copy From"::Regrading;
    //             TrecBTElisa.INSERT;
    //         END;//LK-26=08-21
    //             //LK
    //         CLEAR(QCResultDeclaration);
    //         QCResultDeclaration.RESET;
    //         QCResultDeclaration.SETCURRENTKEY("Temp Item No.", "Lab Code", "Temp Season Code", "Temp Bute No.", Invalid);
    //         QCResultDeclaration.SETRANGE("Temp Item No.", Rec50008."Item No.");
    //         QCResultDeclaration.SETRANGE("Lab Code", NewQCSampleCode);
    //         QCResultDeclaration.SETRANGE("Temp Season Code", TrecBTElisa."Temp Season Code");
    //         QCResultDeclaration.SETRANGE("Temp Bute No.", LotNo);
    //         QCResultDeclaration.SETRANGE(Invalid, FALSE);
    //         QCResultDeclaration.SETRANGE(Posted, FALSE);
    //         QCResultDeclaration.SETRANGE("Prefix No.", Rec50008."Prefix No.");
    //         IF QCResultDeclaration.FINDFIRST THEN BEGIN
    //             QCResultDeclaration.VALIDATE("Temp BT/Elisa Result", TrecBTElisa.Result);
    //             QCResultDeclaration.VALIDATE("Temp BT/Elisa Test Date", TrecBTElisa."Date of Testing");
    //             QCResultDeclaration.VALIDATE("Temp BT/Elisa Test User", TrecBTElisa."Result User Id");
    //             IF QCResultDeclaration."Temp Item No." = '' THEN
    //                 QCResultDeclaration.VALIDATE("Temp Item No.", TrecBTElisa."Item No.");
    //             QCResultDeclaration."Prefix No." := TrecBTElisa."Prefix No.";
    //             QCResultDeclaration.MODIFY(TRUE);
    //         END ELSE
    //             IF NOT QCResultDeclaration.FINDFIRST THEN BEGIN
    //                 QCResultDeclaration.VALIDATE("Lab Code", NewQCSampleCode);
    //                 QCResultDeclaration.VALIDATE("Temp Season Code", Rec50007.Season);
    //                 QCResultDeclaration.VALIDATE("Temp Document No.", documentno);
    //                 QCResultDeclaration.VALIDATE("Temp Variant Code", Rec50007."To Stage");
    //                 QCResultDeclaration.VALIDATE("Temp Bute No.", LotNo);
    //                 QCResultDeclaration.VALIDATE("Process Transfer Entry", TRUE);
    //                 QCResultDeclaration.VALIDATE("Temp BT/Elisa Result", TrecBTElisa.Result);
    //                 QCResultDeclaration.VALIDATE("Temp BT/Elisa Test Date", TrecBTElisa."Date of Testing");
    //                 QCResultDeclaration.VALIDATE("Temp BT/Elisa Test User", TrecBTElisa."Result User Id");
    //                 IF QCResultDeclaration."Temp Item No." = '' THEN
    //                     QCResultDeclaration.VALIDATE("Temp Item No.", TrecBTElisa."Item No.");
    //                 QCResultDeclaration."Prefix No." := Rec50008."Prefix No.";
    //                 QCResultDeclaration.INSERT(TRUE);
    //             END;
    //         //LK
    //     END;
    // end;

    // // [Scope('Internal')]
    // procedure InvalidatingQCSampleEntriesOfSTL(InvalidSampleCode: Code[20]; SeasonCode: Code[20]; LotNo: Code[20]; VariantCode: Code[20]; Rec50007: Record "Process Header"; FromButteNo: Code[10]; Rec50008: Record "Process Line")
    // var
    //     recGD: Record "Germination Evaluation";
    //     recPPD: Record "Physical Purity Determination";
    //     recMD: Record "Moisture Determination";
    //     recVT: Record "Vigour Test";
    //     recQCR: Record "QC Result Declaration";
    //     Rec27: Record Item;
    // begin
    //     //GD
    //     Rec27.GET(Rec50008."Item No.");

    //     recGD.RESET;
    //     recGD.SETCURRENTKEY("Item No.", "Bute No.", "Temp Season Code", Invalid);
    //     IF Rec27."FG Pack Size" > 0 THEN BEGIN
    //         recGD.SETRANGE("Sample Code", InvalidSampleCode);
    //         recGD.SETRANGE("Prefix No.", Rec50008."Prefix No.");
    //     END;
    //     IF Rec50007.Regrading THEN
    //         recGD.SETRANGE("Bute No.", LotNo)
    //     ELSE
    //         IF Rec50007.RVD THEN
    //             recGD.SETRANGE("Bute No.", FromButteNo);
    //     // recGD.SETRANGE(Stage,VariantCode);
    //     recGD.SETRANGE("Temp Season Code", Rec50007.Season);
    //     recGD.SETRANGE(Invalid, FALSE);
    //     recGD.SETRANGE("Item No.", Rec50008."Item No.");
    //     IF recGD.FINDSET THEN BEGIN
    //         REPEAT
    //             recGD.VALIDATE(Invalid, TRUE);
    //             recGD.VALIDATE("Invalid User Id", USERID);
    //             recGD.MODIFY;
    //         UNTIL recGD.NEXT = 0;
    //     END;

    //     //PPD
    //     recPPD.RESET;
    //     recPPD.SETCURRENTKEY("Item No.", "Bute No.", "Temp Season Code", Invalid);
    //     IF Rec27."FG Pack Size" > 0 THEN BEGIN
    //         recPPD.SETRANGE("Sample Code", InvalidSampleCode);
    //         recPPD.SETRANGE("Prefix No.", Rec50008."Prefix No.");
    //     END;
    //     IF Rec50007.Regrading THEN
    //         recPPD.SETRANGE("Bute No.", LotNo)
    //     ELSE
    //         IF Rec50007.RVD THEN
    //             recPPD.SETRANGE("Bute No.", FromButteNo);
    //     // recPPD.SETRANGE(Stage,VariantCode);
    //     recPPD.SETRANGE("Temp Season Code", Rec50007.Season);
    //     recPPD.SETRANGE(Invalid, FALSE);
    //     recPPD.SETRANGE("Item No.", Rec50008."Item No.");
    //     IF recPPD.FINDSET THEN BEGIN
    //         REPEAT
    //             recPPD.VALIDATE(Invalid, TRUE);
    //             recPPD.VALIDATE("Invalid User Id", USERID);
    //             recPPD.MODIFY;
    //         UNTIL recPPD.NEXT = 0;
    //     END;

    //     //MD
    //     recMD.RESET;
    //     recMD.SETCURRENTKEY("Item No.", "Bute No.", "Temp Season Code", Invalid);
    //     IF Rec27."FG Pack Size" > 0 THEN BEGIN
    //         recMD.SETRANGE("Sample Code", InvalidSampleCode);
    //         recMD.SETRANGE("Prefix No.", Rec50008."Prefix No.");
    //     END;
    //     IF Rec50007.Regrading THEN
    //         recMD.SETRANGE("Bute No.", LotNo)
    //     ELSE
    //         IF Rec50007.RVD THEN
    //             recMD.SETRANGE("Bute No.", FromButteNo);
    //     // recMD.SETRANGE(Stage,VariantCode);
    //     recMD.SETRANGE("Temp Season Code", Rec50007.Season);
    //     recMD.SETRANGE(Invalid, FALSE);
    //     recMD.SETRANGE("Item No.", Rec50008."Item No.");
    //     IF recMD.FINDSET THEN BEGIN
    //         REPEAT
    //             recMD.VALIDATE(Invalid, TRUE);
    //             recMD.VALIDATE("Invalid User Id", USERID);
    //             recMD.MODIFY;
    //         UNTIL recMD.NEXT = 0;
    //     END;

    //     //VT
    //     recVT.RESET;
    //     recVT.SETCURRENTKEY("Item No.", "Bute No.", "Temp Season Code", Invalid);
    //     IF Rec27."FG Pack Size" > 0 THEN BEGIN
    //         recVT.SETRANGE("Sample Code", InvalidSampleCode);
    //         recVT.SETRANGE("Prefix No.", Rec50008."Prefix No.");
    //     END;
    //     IF Rec50007.Regrading THEN
    //         recVT.SETRANGE("Bute No.", LotNo)
    //     ELSE
    //         IF Rec50007.RVD THEN
    //             recVT.SETRANGE("Bute No.", FromButteNo);
    //     // recVT.SETRANGE(Stage,VariantCode);
    //     recVT.SETRANGE("Temp Season Code", Rec50007.Season);
    //     recVT.SETRANGE(Invalid, FALSE);
    //     recVT.SETRANGE("Item No.", Rec50008."Item No.");
    //     IF recVT.FINDSET THEN BEGIN
    //         REPEAT
    //             recVT.VALIDATE(Invalid, TRUE);
    //             recVT.VALIDATE("Invalid User Id", USERID);
    //             recVT.MODIFY;
    //         UNTIL recVT.NEXT = 0;
    //     END;

    //     //recQCR
    //     recQCR.RESET;
    //     recQCR.SETCURRENTKEY("Temp Item No.", "Temp Bute No.", "Temp Season Code", Invalid);
    //     recQCR.SETRANGE("Temp Item No.", Rec50008."Item No.");
    //     IF Rec27."FG Pack Size" > 0 THEN BEGIN
    //         recQCR.SETRANGE("Lab Code", InvalidSampleCode);
    //         recQCR.SETRANGE("Prefix No.", Rec50008."Prefix No.");
    //     END;
    //     IF Rec50007.Regrading THEN
    //         recQCR.SETRANGE("Temp Bute No.", LotNo)
    //     ELSE
    //         IF Rec50007.RVD THEN
    //             recQCR.SETRANGE("Temp Bute No.", FromButteNo);
    //     recQCR.SETRANGE("Temp Season Code", Rec50007.Season);
    //     recQCR.SETRANGE(Invalid, FALSE);
    //     IF recQCR.FINDSET THEN BEGIN
    //         REPEAT
    //             recQCR.VALIDATE(Invalid, TRUE);
    //             recQCR.VALIDATE("Invalid User Id", USERID);
    //             recQCR.MODIFY;
    //         UNTIL recQCR.NEXT = 0;
    //     END;
    // end;

    // local procedure GetOldSampleCode(var Trec50007: Record "Process Header")
    // var
    //     rec50019: Record "Lot Range Master";
    // begin
    //     rec50019.RESET;
    //     rec50019.SETCURRENTKEY("Season Code", "Production Location", Item, Blocked);
    //     rec50019.SETRANGE("Season Code", Trec50007.Season);
    //     rec50019.SETRANGE("Production Location", Trec50007.Location);
    //     rec50019.SETRANGE(Item, Trec50007."Item No.");
    //     rec50019.SETRANGE(Type, rec50019.Type::"Sample Code");
    //     rec50019.SETRANGE(Blocked, FALSE);
    //     IF rec50019.FINDFIRST THEN BEGIN
    //         rec50019.TESTFIELD("Next Available Lot");
    //         rec50019.TESTFIELD("Last No. Used");
    //         IF rec50019."Next Available Lot" = INCSTR(rec50019."Last No. Used") THEN
    //             SampleCode := rec50019."Last No. Used"
    //         ELSE
    //             ERROR('Unable to fetch Lab Code No.');
    //     END ELSE
    //         ERROR('Lot Range Master with Item No. %1, Season %2, Location %3, Type Sample Code doesnot exist.', Trec50007."Item No.", Trec50007.Season, Trec50007.Location);
    // end;

    // local procedure CreateGot(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL; AllowedDuplicate: Boolean)
    // var
    //     recGot: Record "Got Testing Master";
    // begin
    //     IF AllowedDuplicate = TRUE THEN BEGIN
    //         //IF NOT recGot.FINDFIRST THEN BEGIN
    //         recGot.RESET;
    //         recGot.INIT;
    //         //for GOT no. series
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         recUL.SETRANGE("Got Testing Master", TRUE);
    //         IF recUL.FINDFIRST THEN BEGIN
    //             IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                 recLoc.TESTFIELD("Got Series");
    //                 recGot."No." := NoSeriesMgt.GetNextNo(recLoc."Got Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //             END ELSE
    //                 ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("Got Series"));
    //         END ELSE
    //             ERROR(ContactAdminText003);

    //         recGot."Crop Code" := Trec50007."Crop Code";
    //         recGot."Document No." := documentno;
    //         recGot."Item No." := Trec50007."Item No.";
    //         recGot."Sample Code" := SampleCode;
    //         recGot."Bute No." := Trec50008."From Bute No.";
    //         recGot."Arrival Qty." := Trec50008."Good Qty.";
    //         IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //             recGot."Source Type" := recGot."Source Type"::"Foundation Process";
    //         IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //             recGot."Source Type" := recGot."Source Type"::"Hybrid Process";
    //         recGot."Stage Code" := Trec50007."To Stage";
    //         recGot."Temp Season Code" := Trec50007.Season;
    //         recGot."Process Transfer Entry" := TRUE;
    //         recGot."Prefix No." := Trec50008."Prefix No.";
    //         recGot.INSERT;
    //     END ELSE BEGIN
    //         recGot.RESET;
    //         recGot.SETCURRENTKEY("Sample Code", "Bute No.", "Temp Season Code", Invalid);
    //         recGot.SETRANGE("Sample Code", SampleCode);
    //         recGot.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         recGot.SETRANGE("Temp Season Code", Trec50007.Season);
    //         //recGot.SETRANGE("Stage Code",Trec50007."To Stage");
    //         recGot.SETRANGE(Invalid, FALSE);
    //         IF NOT recGot.FINDFIRST THEN BEGIN
    //             recGot.RESET;
    //             recGot.INIT;
    //             //for GOT no. series
    //             recUL.RESET;
    //             recUL.SETCURRENTKEY("User ID");
    //             recUL.SETRANGE("User ID", USERID);
    //             recUL.SETRANGE("Got Testing Master", TRUE);
    //             IF recUL.FINDFIRST THEN BEGIN
    //                 IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                     recLoc.TESTFIELD("Got Series");
    //                     recGot."No." := NoSeriesMgt.GetNextNo(recLoc."Got Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //                 END ELSE
    //                     ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("Got Series"));
    //             END ELSE
    //                 ERROR(ContactAdminText003);

    //             recGot."Crop Code" := Trec50007."Crop Code";
    //             recGot."Document No." := documentno;
    //             recGot."Item No." := Trec50007."Item No.";
    //             recGot."Sample Code" := SampleCode;
    //             recGot."Bute No." := Trec50008."From Bute No.";
    //             recGot."Arrival Qty." := Trec50008."Good Qty.";
    //             IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //                 recGot."Source Type" := recGot."Source Type"::"Foundation Process";
    //             IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //                 recGot."Source Type" := recGot."Source Type"::"Hybrid Process";
    //             recGot."Stage Code" := Trec50007."To Stage";
    //             recGot."Temp Season Code" := Trec50007.Season;
    //             recGot."Process Transfer Entry" := TRUE;
    //             recGot."Prefix No." := Trec50008."Prefix No.";
    //             recGot.INSERT;
    //         END;
    //     END;
    // end;

    // local procedure CreateBT(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL; AllowDuplicate: Boolean)
    // var
    //     recBt: Record "BT/Elisa Testing Master";
    // begin
    //     IF AllowDuplicate THEN BEGIN
    //         recBt.RESET;
    //         recBt.INIT;
    //         //for BT no. series
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         recUL.SETRANGE("BT Testing Master", TRUE);
    //         IF recUL.FINDFIRST THEN BEGIN
    //             IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                 recLoc.TESTFIELD("BT Series");
    //                 recBt."No." := NoSeriesMgt.GetNextNo(recLoc."BT Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //             END ELSE
    //                 ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("BT Series"));
    //         END ELSE
    //             ERROR(ContactAdminText003);

    //         recBt."Crop Code" := Trec50007."Crop Code";
    //         recBt."Document No." := documentno;
    //         recBt."Item No." := Trec50007."Item No.";
    //         recBt."Sample Code" := SampleCode;
    //         recBt."Bute No." := Trec50008."From Bute No.";
    //         recBt."Qty. of Arrival" := Trec50008."Good Qty.";
    //         IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //             recBt."Source Type" := recBt."Source Type"::"Foundation Process";
    //         IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //             recBt."Source Type" := recBt."Source Type"::"Hybrid Process";
    //         recBt."Stage Code" := Trec50007."To Stage";
    //         recBt."Temp Season Code" := Trec50007.Season;
    //         recBt."Process Transfer Entry" := TRUE;
    //         recBt."Prefix No." := Trec50008."Prefix No.";
    //         recBt.INSERT;
    //     END ELSE BEGIN
    //         recBt.RESET;
    //         recBt.SETCURRENTKEY("Sample Code", "Bute No.", "Temp Season Code", Invalid);
    //         recBt.SETRANGE("Sample Code", SampleCode);
    //         recBt.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         recBt.SETRANGE("Temp Season Code", Trec50007.Season);
    //         //    recBt.SETRANGE("Stage Code",Trec50007."To Stage");
    //         recBt.SETRANGE(Invalid, FALSE);
    //         IF NOT recBt.FINDFIRST THEN BEGIN
    //             recBt.RESET;
    //             recBt.INIT;
    //             //for BT no. series
    //             recUL.RESET;
    //             recUL.SETCURRENTKEY("User ID");
    //             recUL.SETRANGE("User ID", USERID);
    //             recUL.SETRANGE("BT Testing Master", TRUE);
    //             IF recUL.FINDFIRST THEN BEGIN
    //                 IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                     recLoc.TESTFIELD("BT Series");
    //                     recBt."No." := NoSeriesMgt.GetNextNo(recLoc."BT Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //                 END ELSE
    //                     ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("BT Series"));
    //             END ELSE
    //                 ERROR(ContactAdminText003);

    //             recBt."Crop Code" := Trec50007."Crop Code";
    //             recBt."Document No." := documentno;
    //             recBt."Item No." := Trec50007."Item No.";
    //             recBt."Sample Code" := SampleCode;
    //             recBt."Bute No." := Trec50008."From Bute No.";
    //             recBt."Qty. of Arrival" := Trec50008."Good Qty.";
    //             IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //                 recBt."Source Type" := recBt."Source Type"::"Foundation Process";
    //             IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //                 recBt."Source Type" := recBt."Source Type"::"Hybrid Process";
    //             recBt."Stage Code" := Trec50007."To Stage";
    //             recBt."Temp Season Code" := Trec50007.Season;
    //             recBt."Process Transfer Entry" := TRUE;
    //             recBt."Prefix No." := Trec50008."Prefix No.";
    //             recBt.INSERT;
    //         END;
    //     END;
    // end;

    // local procedure CreateGD(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL; AllowDuplicate: Boolean)
    // var
    //     recGD: Record "Germination Evaluation";
    // begin
    //     IF AllowDuplicate THEN BEGIN
    //         recGD.RESET;
    //         recGD.INIT;
    //         //for Result Declaration no. series
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         recUL.SETRANGE("Germination Determination", TRUE);
    //         IF recUL.FINDFIRST THEN BEGIN
    //             IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                 recLoc.TESTFIELD("GD Series");
    //                 recGD."No." := NoSeriesMgt.GetNextNo(recLoc."GD Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //             END ELSE
    //                 ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("GD Series"));
    //         END ELSE
    //             ERROR(ContactAdminText003);

    //         recGD."Crop Code" := Trec50007."Crop Code";
    //         recGD."Document No." := documentno;
    //         recGD."Item No." := Trec50007."Item No.";
    //         recGD."Sample Code" := SampleCode;
    //         recGD."Bute No." := Trec50008."From Bute No.";
    //         recGD."Qty (Kg)" := Trec50008."Good Qty.";
    //         IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //             recGD."Source Type" := recGD."Source Type"::"Foundation Process";
    //         IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //             recGD."Source Type" := recGD."Source Type"::"Hybrid Process";
    //         recGD.Stage := Trec50007."To Stage";
    //         recGD."Temp Season Code" := Trec50007.Season;
    //         recGD."Process Transfer Entry" := TRUE;
    //         //recGD."Current Stage QTY" := Trec50008."Good Qty.";
    //         //  IF (recGD."Crop Code" = 'VEG') OR (recGD."Crop Code" = 'FCROP') THEN
    //         //    recGD."Subjected to Retest" := TRUE;
    //         recGD."Prefix No." := Trec50008."Prefix No.";
    //         recGD.INSERT;
    //     END ELSE BEGIN
    //         recGD.RESET;
    //         recGD.SETCURRENTKEY("Sample Code", "Bute No.", "Temp Season Code", Invalid);
    //         recGD.SETRANGE("Sample Code", SampleCode);
    //         recGD.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         recGD.SETRANGE("Temp Season Code", Trec50007.Season);
    //         //    recGD.SETRANGE(Stage,Trec50007."To Stage");
    //         recGD.SETRANGE(Invalid, FALSE);
    //         IF NOT recGD.FINDFIRST THEN BEGIN
    //             recGD.RESET;
    //             recGD.INIT;
    //             //for Result Declaration no. series
    //             recUL.RESET;
    //             recUL.SETCURRENTKEY("User ID");
    //             recUL.SETRANGE("User ID", USERID);
    //             recUL.SETRANGE("Germination Determination", TRUE);
    //             IF recUL.FINDFIRST THEN BEGIN
    //                 IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                     recLoc.TESTFIELD("GD Series");
    //                     recGD."No." := NoSeriesMgt.GetNextNo(recLoc."GD Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //                 END ELSE
    //                     ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("GD Series"));
    //             END ELSE
    //                 ERROR(ContactAdminText003);

    //             recGD."Crop Code" := Trec50007."Crop Code";
    //             recGD."Document No." := documentno;
    //             recGD."Item No." := Trec50007."Item No.";
    //             recGD."Sample Code" := SampleCode;
    //             recGD."Bute No." := Trec50008."From Bute No.";
    //             recGD."Qty (Kg)" := Trec50008."Good Qty.";
    //             IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //                 recGD."Source Type" := recGD."Source Type"::"Foundation Process";
    //             IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //                 recGD."Source Type" := recGD."Source Type"::"Hybrid Process";
    //             recGD.Stage := Trec50007."To Stage";
    //             recGD."Temp Season Code" := Trec50007.Season;
    //             recGD."Process Transfer Entry" := TRUE;
    //             // recGD."Current Stage QTY" := Trec50008."Good Qty.";
    //             //  IF (recGD."Crop Code" = 'VEG') OR (recGD."Crop Code" = 'FCROP') THEN
    //             //    recGD."Subjected to Retest" := TRUE;
    //             recGD."Prefix No." := Trec50008."Prefix No.";
    //             recGD.INSERT;
    //         END;
    //     END;
    // end;

    // local procedure CreatePPD(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL; AllowDuplicate: Boolean)
    // var
    //     recPPD: Record "Physical Purity Determination";
    // begin
    //     IF AllowDuplicate THEN BEGIN
    //         recPPD.RESET;
    //         recPPD.INIT;
    //         //for Result Declaration no. series
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         recUL.SETRANGE("Physical Purity Determination", TRUE);
    //         IF recUL.FINDFIRST THEN BEGIN
    //             IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                 recLoc.TESTFIELD("PPD Series");
    //                 recPPD."No." := NoSeriesMgt.GetNextNo(recLoc."PPD Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //             END ELSE
    //                 ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("PPD Series"));
    //         END ELSE
    //             ERROR(ContactAdminText003);

    //         recPPD."Crop Code" := Trec50007."Crop Code";
    //         recPPD."Document No." := documentno;
    //         recPPD."Item No." := Trec50007."Item No.";
    //         recPPD."Sample Code" := SampleCode;
    //         recPPD."Bute No." := Trec50008."From Bute No.";
    //         recPPD."Qty (Kg)" := Trec50008."Good Qty.";
    //         IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //             recPPD."Source Type" := recPPD."Source Type"::"Foundation Process";
    //         IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //             recPPD."Source Type" := recPPD."Source Type"::"Hybrid Process";
    //         recPPD.Stage := Trec50007."To Stage";
    //         recPPD."Temp Season Code" := Trec50007.Season;
    //         recPPD."Process Transfer Entry" := TRUE;
    //         recPPD."Prefix No." := Trec50008."Prefix No.";
    //         recPPD.INSERT;
    //     END ELSE BEGIN
    //         recPPD.RESET;
    //         recPPD.SETCURRENTKEY("Sample Code", "Bute No.", "Temp Season Code", Invalid);
    //         recPPD.SETRANGE("Sample Code", SampleCode);
    //         recPPD.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         recPPD.SETRANGE("Temp Season Code", Trec50007.Season);
    //         //    recPPD.SETRANGE(Stage,Trec50007."To Stage");
    //         recPPD.SETRANGE(Invalid, FALSE);
    //         IF NOT recPPD.FINDFIRST THEN BEGIN
    //             recPPD.RESET;
    //             recPPD.INIT;
    //             //for Result Declaration no. series
    //             recUL.RESET;
    //             recUL.SETCURRENTKEY("User ID");
    //             recUL.SETRANGE("User ID", USERID);
    //             recUL.SETRANGE("Physical Purity Determination", TRUE);
    //             IF recUL.FINDFIRST THEN BEGIN
    //                 IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                     recLoc.TESTFIELD("PPD Series");
    //                     recPPD."No." := NoSeriesMgt.GetNextNo(recLoc."PPD Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //                 END ELSE
    //                     ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("PPD Series"));
    //             END ELSE
    //                 ERROR(ContactAdminText003);

    //             recPPD."Crop Code" := Trec50007."Crop Code";
    //             recPPD."Document No." := documentno;
    //             recPPD."Item No." := Trec50007."Item No.";
    //             recPPD."Sample Code" := SampleCode;
    //             recPPD."Bute No." := Trec50008."From Bute No.";
    //             recPPD."Qty (Kg)" := Trec50008."Good Qty.";
    //             IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //                 recPPD."Source Type" := recPPD."Source Type"::"Foundation Process";
    //             IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //                 recPPD."Source Type" := recPPD."Source Type"::"Hybrid Process";
    //             recPPD.Stage := Trec50007."To Stage";
    //             recPPD."Temp Season Code" := Trec50007.Season;
    //             recPPD."Process Transfer Entry" := TRUE;
    //             recPPD."Prefix No." := Trec50008."Prefix No.";
    //             recPPD.INSERT;
    //         END;
    //     END;
    // end;

    // local procedure CreateMD(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL; AllowDuplicate: Boolean)
    // var
    //     recMD: Record "Moisture Determination";
    // begin
    //     IF AllowDuplicate THEN BEGIN
    //         recMD.RESET;
    //         recMD.INIT;
    //         //for Result Declaration no. series
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         recUL.SETRANGE("Moisture Determination", TRUE);
    //         IF recUL.FINDFIRST THEN BEGIN
    //             IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                 recLoc.TESTFIELD("MD Series");
    //                 recMD."No." := NoSeriesMgt.GetNextNo(recLoc."MD Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //             END ELSE
    //                 ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("MD Series"));
    //         END ELSE
    //             ERROR(ContactAdminText003);

    //         recMD."Crop Code" := Trec50007."Crop Code";
    //         recMD."Document No." := documentno;
    //         recMD."Item No." := Trec50007."Item No.";
    //         recMD."Sample Code" := SampleCode;
    //         recMD."Bute No." := Trec50008."From Bute No.";
    //         recMD."Qty (Kg)" := Trec50008."Good Qty.";
    //         IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //             recMD."Source Type" := recMD."Source Type"::"Foundation Process";
    //         IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //             recMD."Source Type" := recMD."Source Type"::"Hybrid Process";
    //         recMD.Stage := Trec50007."To Stage";
    //         recMD."Temp Season Code" := Trec50007.Season;
    //         recMD."Process Transfer Entry" := TRUE;
    //         recMD."Prefix No." := Trec50008."Prefix No.";
    //         recMD.INSERT;
    //     END ELSE BEGIN
    //         recMD.RESET;
    //         recMD.SETCURRENTKEY("Sample Code", "Bute No.", "Temp Season Code", Invalid);
    //         recMD.SETRANGE("Sample Code", SampleCode);
    //         recMD.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         recMD.SETRANGE("Temp Season Code", Trec50007.Season);
    //         //    recMD.SETRANGE(Stage,Trec50007."To Stage");
    //         recMD.SETRANGE(Invalid, FALSE);
    //         IF NOT recMD.FINDFIRST THEN BEGIN
    //             recMD.RESET;
    //             recMD.INIT;
    //             //for Result Declaration no. series
    //             recUL.RESET;
    //             recUL.SETCURRENTKEY("User ID");
    //             recUL.SETRANGE("User ID", USERID);
    //             recUL.SETRANGE("Moisture Determination", TRUE);
    //             IF recUL.FINDFIRST THEN BEGIN
    //                 IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                     recLoc.TESTFIELD("MD Series");
    //                     recMD."No." := NoSeriesMgt.GetNextNo(recLoc."MD Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //                 END ELSE
    //                     ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("MD Series"));
    //             END ELSE
    //                 ERROR(ContactAdminText003);

    //             recMD."Crop Code" := Trec50007."Crop Code";
    //             recMD."Document No." := documentno;
    //             recMD."Item No." := Trec50007."Item No.";
    //             recMD."Sample Code" := SampleCode;
    //             recMD."Bute No." := Trec50008."From Bute No.";
    //             recMD."Qty (Kg)" := Trec50008."Good Qty.";
    //             IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //                 recMD."Source Type" := recMD."Source Type"::"Foundation Process";
    //             IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //                 recMD."Source Type" := recMD."Source Type"::"Hybrid Process";
    //             recMD.Stage := Trec50007."To Stage";
    //             recMD."Temp Season Code" := Trec50007.Season;
    //             recMD."Process Transfer Entry" := TRUE;
    //             recMD."Prefix No." := Trec50008."Prefix No.";
    //             recMD.INSERT;
    //         END;
    //     END;
    // end;

    // local procedure CreateVT(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL; AllowDuplicate: Boolean)
    // var
    //     recVT: Record "Vigour Test";
    // begin
    //     IF AllowDuplicate THEN BEGIN
    //         recVT.RESET;
    //         recVT.INIT;
    //         //for Result Declaration no. series
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         recUL.SETRANGE("Vigour Test", TRUE);
    //         IF recUL.FINDFIRST THEN BEGIN
    //             IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                 recLoc.TESTFIELD("VT Series");
    //                 recVT."No." := NoSeriesMgt.GetNextNo(recLoc."VT Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //             END ELSE
    //                 ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("VT Series"));
    //         END ELSE
    //             ERROR(ContactAdminText003);

    //         recVT."Crop Code" := Trec50007."Crop Code";
    //         recVT."Document No." := documentno;
    //         recVT."Item No." := Trec50007."Item No.";
    //         recVT."Sample Code" := SampleCode;
    //         recVT."Bute No." := Trec50008."From Bute No.";
    //         recVT."Qty (Kg)" := Trec50008."Good Qty.";
    //         IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //             recVT."Source Type" := recVT."Source Type"::"Foundation Process";
    //         IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //             recVT."Source Type" := recVT."Source Type"::"Hybrid Process";
    //         recVT.Stage := Trec50007."To Stage";
    //         recVT."Temp Season Code" := Trec50007.Season;
    //         recVT."Process Transfer Entry" := TRUE;
    //         recVT."Prefix No." := Trec50008."Prefix No.";
    //         recVT.INSERT;
    //     END ELSE BEGIN
    //         recVT.RESET;
    //         recVT.SETCURRENTKEY("Sample Code", "Bute No.", "Temp Season Code", Invalid);
    //         recVT.SETRANGE("Sample Code", SampleCode);
    //         recVT.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //         recVT.SETRANGE("Temp Season Code", Trec50007.Season);
    //         //    recVT.SETRANGE(Stage,Trec50007."To Stage");
    //         recVT.SETRANGE(Invalid, FALSE);
    //         IF NOT recVT.FINDFIRST THEN BEGIN
    //             recVT.RESET;
    //             recVT.INIT;
    //             //for Result Declaration no. series
    //             recUL.RESET;
    //             recUL.SETCURRENTKEY("User ID");
    //             recUL.SETRANGE("User ID", USERID);
    //             recUL.SETRANGE("Vigour Test", TRUE);
    //             IF recUL.FINDFIRST THEN BEGIN
    //                 IF recLoc.GET(Trec50007.Location) THEN BEGIN
    //                     recLoc.TESTFIELD("VT Series");
    //                     recVT."No." := NoSeriesMgt.GetNextNo(recLoc."VT Series", Trec50007.Date, TRUE);//PBS Kanhaiya
    //                 END ELSE
    //                     ERROR(Text002, recUL."Location Code", recLoc.FIELDCAPTION("VT Series"));
    //             END ELSE
    //                 ERROR(ContactAdminText003);

    //             recVT."Crop Code" := Trec50007."Crop Code";
    //             recVT."Document No." := documentno;
    //             recVT."Item No." := Trec50007."Item No.";
    //             recVT."Sample Code" := SampleCode;
    //             recVT."Bute No." := Trec50008."From Bute No.";
    //             recVT."Qty (Kg)" := Trec50008."Good Qty.";
    //             IF ClassOfSeeds = ClassOfSeeds::Foundation THEN
    //                 recVT."Source Type" := recVT."Source Type"::"Foundation Process";
    //             IF ClassOfSeeds = ClassOfSeeds::TL THEN
    //                 recVT."Source Type" := recVT."Source Type"::"Hybrid Process";
    //             recVT.Stage := Trec50007."To Stage";
    //             recVT."Temp Season Code" := Trec50007.Season;
    //             recVT."Process Transfer Entry" := TRUE;
    //             recVT."Prefix No." := Trec50008."Prefix No.";
    //             recVT.INSERT;
    //         END;
    //     END;
    // end;

    // local procedure CreateGDForRevalidation(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL)
    // var
    //     recGD: Record "Germination Evaluation";
    //     TrecGD: Record "Germination Evaluation";
    // begin
    //     //GD
    //     recGD.RESET;
    //     recGD.SETCURRENTKEY("Sample Code", Invalid);
    //     recGD.SETRANGE("Sample Code", SampleCode);
    //     recGD.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //     recGD.SETRANGE("Temp Season Code", Trec50007.Season);
    //     recGD.SETRANGE(Stage, Trec50007."To Stage");
    //     recGD.SETRANGE(Invalid, FALSE);
    //     IF recGD.FINDSET THEN BEGIN
    //         REPEAT
    //             recGD.VALIDATE(Invalid, TRUE);
    //             recGD.VALIDATE("Invalid User Id", USERID);
    //             recGD.MODIFY;
    //         UNTIL recGD.NEXT = 0;
    //     END;

    //     //Create New Sample
    //     CreateGD(Trec50007, Trec50008, ClassOfSeeds, FALSE);


    // end;

    // local procedure CreatePPDForRevalidation(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL)
    // var
    //     recPPD: Record "Physical Purity Determination";
    //     TrecPPD: Record "Physical Purity Determination";
    // begin
    //     //PPD
    //     recPPD.RESET;
    //     recPPD.SETCURRENTKEY("Sample Code", Invalid);
    //     recPPD.SETRANGE("Sample Code", SampleCode);
    //     recPPD.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //     recPPD.SETRANGE("Temp Season Code", Trec50007.Season);
    //     recPPD.SETRANGE(Stage, Trec50007."To Stage");
    //     recPPD.SETRANGE(Invalid, FALSE);
    //     IF recPPD.FINDSET THEN BEGIN
    //         REPEAT
    //             recPPD.VALIDATE(Invalid, TRUE);
    //             recPPD.VALIDATE("Invalid User Id", USERID);
    //             recPPD.MODIFY;
    //         UNTIL recPPD.NEXT = 0;
    //     END;

    //     //Create New Sample
    //     CreatePPD(Trec50007, Trec50008, ClassOfSeeds, FALSE);

    // end;

    // local procedure CreateMDForRevalidation(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL)
    // var
    //     recMD: Record "Moisture Determination";
    //     TrecMD: Record "Moisture Determination";
    // begin
    //     //MD
    //     recMD.RESET;
    //     recMD.SETCURRENTKEY("Sample Code", Invalid);
    //     recMD.SETRANGE("Sample Code", SampleCode);
    //     recMD.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //     recMD.SETRANGE("Temp Season Code", Trec50007.Season);
    //     recMD.SETRANGE(Stage, Trec50007."To Stage");
    //     recMD.SETRANGE(Invalid, FALSE);
    //     IF recMD.FINDSET THEN BEGIN
    //         REPEAT
    //             recMD.VALIDATE(Invalid, TRUE);
    //             recMD.VALIDATE("Invalid User Id", USERID);
    //             recMD.MODIFY;
    //         UNTIL recMD.NEXT = 0;
    //     END;

    //     //Create New Sample
    //     CreateMD(Trec50007, Trec50008, ClassOfSeeds, FALSE);


    // end;

    // local procedure CreateVTForRevalidation(var Trec50007: Record "Process Header"; var Trec50008: Record "Process Line"; ClassOfSeeds: Option " ",Breeder,Foundation,TL)
    // var
    //     recVT: Record "Vigour Test";
    //     TrecVT: Record "Vigour Test";
    // begin
    //     //VT
    //     recVT.RESET;
    //     recVT.SETCURRENTKEY("Sample Code", Invalid);
    //     recVT.SETRANGE("Sample Code", SampleCode);
    //     recVT.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //     recVT.SETRANGE("Temp Season Code", Trec50007.Season);
    //     recVT.SETRANGE(Stage, Trec50007."To Stage");
    //     recVT.SETRANGE(Invalid, FALSE);
    //     IF recVT.FINDSET THEN BEGIN
    //         REPEAT
    //             recVT.VALIDATE(Invalid, TRUE);
    //             recVT.VALIDATE("Invalid User Id", USERID);
    //             recVT.MODIFY;
    //         UNTIL recVT.NEXT = 0;
    //     END;

    //     //Create New Sample
    //     CreateVT(Trec50007, Trec50008, ClassOfSeeds, FALSE);

    // end;

    // // [Scope('Internal')]
    // procedure CreateRetestForFailResult(VarSampleCode: Code[20]; LotNo: Code[20]; SeasonCode: Code[20]; ItemNo: Code[20]; VariantCode: Code[20]; TestType: Option " ",Got,"BT/Elisa","Germination  Determination","Physical Purity Determination","Moisture Determination","Vigour Test"; PrimaryKeyNo: Code[20])
    // var
    //     RetestMaster: Record "Retest Master";
    //     InventorySetup: Record "Inventory Setup";
    //     GotTestingMaster: Record "Got Testing Master";
    //     BTElisaTestingMaster: Record "BT/Elisa Testing Master";
    //     GerminationEvaluation: Record "Germination Evaluation";
    //     PhysicalPurityDetermination: Record "Physical Purity Determination";
    //     MoistureDetermination: Record "Moisture Determination";
    //     VigourTest: Record "Vigour Test";
    //     ProceedSuccessfully: Boolean;
    // begin
    //     IF (VarSampleCode = '') OR (LotNo = '') OR (SeasonCode = '') OR (ItemNo = '') OR (VariantCode = '') OR (TestType = TestType::" ") OR (PrimaryKeyNo = '') THEN
    //         ERROR('Unable to Process Automation of Retest. Function Parameters cannot be Blank.');

    //     InvalidatingQCSampleEntriesOfAllTestsStageWiseDown(VarSampleCode, SeasonCode, LotNo, ItemNo, VariantCode, TestType);

    //     CLEAR(ProceedSuccessfully);
    //     InventorySetup.RESET;
    //     InventorySetup.GET;
    //     CASE TestType OF
    //         TestType::Got:
    //             BEGIN
    //                 //      GotTestingMaster.RESET;
    //                 //      GotTestingMaster.SETRANGE("Sample Code",VarSampleCode);
    //                 //      GotTestingMaster.SETRANGE("Temp Season Code",SeasonCode);
    //                 //      GotTestingMaster.SETRANGE("Bute No.",LotNo);
    //                 //      GotTestingMaster.SETRANGE(Invalid,FALSE);
    //                 //      GotTestingMaster.SETRANGE(Posted,TRUE);
    //                 //      GotTestingMaster.SETRANGE("Item No.",ItemNo);
    //                 //      GotTestingMaster.SETRANGE("Stage Code",VariantCode);
    //                 //      GotTestingMaster.FINDFIRST;
    //                 GotTestingMaster.GET(PrimaryKeyNo);
    //                 IF GotTestingMaster."Subjected to Retest" = FALSE THEN
    //                     EXIT
    //                 ELSE
    //                     ProceedSuccessfully := TRUE;
    //             END;
    //         TestType::"BT/Elisa":
    //             BEGIN
    //                 BTElisaTestingMaster.RESET;
    //                 BTElisaTestingMaster.SETRANGE("Sample Code", VarSampleCode);
    //                 BTElisaTestingMaster.SETRANGE("Temp Season Code", SeasonCode);
    //                 BTElisaTestingMaster.SETRANGE("Bute No.", LotNo);
    //                 BTElisaTestingMaster.SETRANGE(Invalid, FALSE);
    //                 BTElisaTestingMaster.SETRANGE(Posted, TRUE);
    //                 BTElisaTestingMaster.SETRANGE("Item No.", ItemNo);
    //                 BTElisaTestingMaster.SETRANGE("Stage Code", VariantCode);
    //                 BTElisaTestingMaster.FINDFIRST;
    //                 IF BTElisaTestingMaster."Subjected to Retest" = FALSE THEN
    //                     EXIT
    //                 ELSE
    //                     ProceedSuccessfully := TRUE;
    //             END;
    //         TestType::"Germination  Determination":
    //             BEGIN
    //                 //      GerminationEvaluation.RESET;
    //                 //      GerminationEvaluation.SETRANGE("Sample Code",VarSampleCode);
    //                 //      GerminationEvaluation.SETRANGE("Temp Season Code",SeasonCode);
    //                 //      GerminationEvaluation.SETRANGE("Bute No.",LotNo);
    //                 //      GerminationEvaluation.SETRANGE(Invalid,FALSE);
    //                 //      GerminationEvaluation.SETRANGE(Posted,TRUE);
    //                 //      GerminationEvaluation.SETRANGE("Item No.",ItemNo);
    //                 //      GerminationEvaluation.SETRANGE(Stage,VariantCode);
    //                 //      GerminationEvaluation.FINDFIRST;
    //                 GerminationEvaluation.GET(PrimaryKeyNo);
    //                 IF GerminationEvaluation."Subjected to Retest" = FALSE THEN
    //                     EXIT
    //                 ELSE
    //                     ProceedSuccessfully := TRUE;
    //             END;
    //         TestType::"Physical Purity Determination":
    //             BEGIN
    //                 //      PhysicalPurityDetermination.RESET;
    //                 //      PhysicalPurityDetermination.SETRANGE("Sample Code",VarSampleCode);
    //                 //      PhysicalPurityDetermination.SETRANGE("Temp Season Code",SeasonCode);
    //                 //      PhysicalPurityDetermination.SETRANGE("Bute No.",LotNo);
    //                 //      PhysicalPurityDetermination.SETRANGE(Invalid,FALSE);
    //                 //      PhysicalPurityDetermination.SETRANGE(Posted,TRUE);
    //                 //      PhysicalPurityDetermination.SETRANGE("Item No.",ItemNo);
    //                 //      PhysicalPurityDetermination.SETRANGE(Stage,VariantCode);
    //                 //      PhysicalPurityDetermination.FINDFIRST;
    //                 PhysicalPurityDetermination.GET(PrimaryKeyNo);
    //                 IF PhysicalPurityDetermination."Subjected to Retest" = FALSE THEN
    //                     EXIT
    //                 ELSE
    //                     ProceedSuccessfully := TRUE;
    //             END;
    //         TestType::"Moisture Determination":
    //             BEGIN
    //                 //      MoistureDetermination.RESET;
    //                 //      MoistureDetermination.SETRANGE("Sample Code",VarSampleCode);
    //                 //      MoistureDetermination.SETRANGE("Temp Season Code",SeasonCode);
    //                 //      MoistureDetermination.SETRANGE("Bute No.",LotNo);
    //                 //      MoistureDetermination.SETRANGE(Invalid,FALSE);
    //                 //      MoistureDetermination.SETRANGE(Posted,TRUE);
    //                 //      MoistureDetermination.SETRANGE("Item No.",ItemNo);
    //                 //      MoistureDetermination.SETRANGE(Stage,VariantCode);
    //                 //      MoistureDetermination.FINDFIRST;
    //                 MoistureDetermination.GET(PrimaryKeyNo);
    //                 IF MoistureDetermination."Subjected to Retest" = FALSE THEN
    //                     EXIT
    //                 ELSE
    //                     ProceedSuccessfully := TRUE;
    //             END;
    //         TestType::"Vigour Test":
    //             BEGIN
    //                 //      VigourTest.RESET;
    //                 //      VigourTest.SETRANGE("Sample Code",VarSampleCode);
    //                 //      VigourTest.SETRANGE("Temp Season Code",SeasonCode);
    //                 //      VigourTest.SETRANGE("Bute No.",LotNo);
    //                 //      VigourTest.SETRANGE(Invalid,FALSE);
    //                 //      VigourTest.SETRANGE(Posted,TRUE);
    //                 //      VigourTest.SETRANGE("Item No.",ItemNo);
    //                 //      VigourTest.SETRANGE(Stage,VariantCode);
    //                 //      VigourTest.FINDFIRST;
    //                 VigourTest.GET(PrimaryKeyNo);
    //                 IF VigourTest."Subjected to Retest" = FALSE THEN
    //                     EXIT
    //                 ELSE
    //                     ProceedSuccessfully := TRUE;
    //             END;
    //     END;

    //     IF ProceedSuccessfully = TRUE THEN BEGIN
    //         RetestMaster.RESET;
    //         RetestMaster.INIT;
    //         RetestMaster.VALIDATE("Test Type", TestType);
    //         RetestMaster.VALIDATE("Lab Code", VarSampleCode);
    //         RetestMaster.VALIDATE("Bute/Lot No.", LotNo);
    //         RetestMaster.VALIDATE("Season Code", SeasonCode);
    //         RetestMaster.VALIDATE("Variant Code", VariantCode);
    //         RetestMaster.INSERT(TRUE);
    //         RetestMaster.TESTFIELD("Test Type");
    //         RetestMaster.TESTFIELD("Lab Code");
    //         RetestMaster.TESTFIELD("Bute/Lot No.");
    //         RetestMaster.TESTFIELD("Season Code");
    //         RetestMaster.SetTestToInvalid;
    //         RetestMaster.SetQCResultToInvalid;
    //         RetestMaster."Retest Date" := TODAY;
    //         RetestMaster."Retest User Id" := USERID;
    //         RetestMaster.Posted := TRUE;
    //         RetestMaster.MODIFY(TRUE);
    //     END;
    // end;

    // // [Scope('Internal')]
    // procedure InvalidatingQCSampleEntriesOfAllTestsStageWiseDown(VarInvalidSampleCode: Code[20]; VarSeasonCode: Code[20]; VarLotNo: Code[20]; VarItemNo: Code[20]; VarVariantCode: Code[20]; TestType: Option " ",Got,"BT/Elisa","Germination  Determination","Physical Purity Determination","Moisture Determination","Vigour Test")
    // var
    //     rec27: Record Item;
    //     recCSM: Record "Crop Stage Master";
    //     TempCropStageMaster: Record "Crop Stage Master";
    //     "count": Integer;
    // begin
    //     IF (VarInvalidSampleCode = '') OR (VarSeasonCode = '') OR (VarLotNo = '') OR (VarItemNo = '') OR (VarVariantCode = '') OR (TestType = TestType::" ") THEN
    //         ERROR('Unable to Process Automation of Invalidating Tests. Function Parameters cannot be Blank.');

    //     rec27.GET(VarItemNo);
    //     recCSM.RESET;
    //     recCSM.SETCURRENTKEY("Crop Code", Stage, Type);
    //     recCSM.SETRANGE("Crop Code", rec27."Crop Code");
    //     recCSM.SETRANGE(Stage, VarVariantCode);
    //     recCSM.SETRANGE(Type, recCSM.Type::"Process Transfer");
    //     IF recCSM.FINDFIRST THEN BEGIN
    //         FOR count := (recCSM.Sequence - 1) DOWNTO 1 DO BEGIN
    //             TempCropStageMaster.RESET;
    //             TempCropStageMaster.SETCURRENTKEY("Crop Code", Sequence, Type);
    //             TempCropStageMaster.SETRANGE("Crop Code", recCSM."Crop Code");
    //             TempCropStageMaster.SETRANGE(Sequence, count);
    //             TempCropStageMaster.SETRANGE(Type, recCSM.Type);
    //             IF TempCropStageMaster.FINDFIRST THEN
    //                 InvalidatingQCSampleEntriesOfAllTest(VarInvalidSampleCode, VarSeasonCode, VarLotNo, VarItemNo, TempCropStageMaster.Stage, TestType);
    //         END;
    //     END;
    // end;

    // local procedure InvalidatingQCSampleEntriesOfAllTest(InvalidSampleCode: Code[20]; SeasonCode: Code[20]; LotNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20]; TestType: Option " ",Got,"BT/Elisa","Germination  Determination","Physical Purity Determination","Moisture Determination","Vigour Test")
    // var
    //     recGOT: Record "Got Testing Master";
    //     recBTElisa: Record "BT/Elisa Testing Master";
    //     recGD: Record "Germination Evaluation";
    //     recPPD: Record "Physical Purity Determination";
    //     recMD: Record "Moisture Determination";
    //     recVT: Record "Vigour Test";
    // begin
    //     IF (InvalidSampleCode = '') OR (SeasonCode = '') OR (LotNo = '') OR (ItemNo = '') OR (VariantCode = '') OR (TestType = TestType::" ") THEN
    //         ERROR('Unable to Process Automation of Invalidating Tests. Function Parameters cannot be Blank.');

    //     CASE TestType OF
    //         TestType::Got:
    //             BEGIN
    //                 recGOT.RESET;
    //                 recGOT.SETCURRENTKEY("Sample Code", Invalid);
    //                 recGOT.SETRANGE("Sample Code", InvalidSampleCode);
    //                 recGOT.SETRANGE("Bute No.", LotNo);
    //                 recGOT.SETRANGE("Temp Season Code", SeasonCode);
    //                 recGOT.SETRANGE("Item No.", ItemNo);
    //                 recGOT.SETRANGE("Stage Code", VariantCode);
    //                 recGOT.SETRANGE(Invalid, FALSE);
    //                 IF recGOT.FINDSET THEN BEGIN
    //                     REPEAT
    //                         recGOT.VALIDATE(Invalid, TRUE);
    //                         recGOT.VALIDATE("Invalid User Id", USERID);
    //                         recGOT.MODIFY;
    //                     UNTIL recGOT.NEXT = 0;
    //                 END;
    //             END;
    //         TestType::"BT/Elisa":
    //             BEGIN
    //                 recBTElisa.RESET;
    //                 recBTElisa.SETCURRENTKEY("Sample Code", Invalid);
    //                 recBTElisa.SETRANGE("Sample Code", InvalidSampleCode);
    //                 recBTElisa.SETRANGE("Bute No.", LotNo);
    //                 recBTElisa.SETRANGE("Stage Code", VariantCode);
    //                 recBTElisa.SETRANGE("Item No.", ItemNo);
    //                 recBTElisa.SETRANGE("Temp Season Code", SeasonCode);
    //                 recBTElisa.SETRANGE(Invalid, FALSE);
    //                 IF recBTElisa.FINDSET THEN BEGIN
    //                     REPEAT
    //                         recBTElisa.VALIDATE(Invalid, TRUE);
    //                         recBTElisa.VALIDATE("Invalid User Id", USERID);
    //                         recBTElisa.MODIFY;
    //                     UNTIL recBTElisa.NEXT = 0;
    //                 END;
    //             END;
    //         TestType::"Germination  Determination":
    //             BEGIN
    //                 recGD.RESET;
    //                 recGD.SETCURRENTKEY("Sample Code", Invalid);
    //                 recGD.SETRANGE("Sample Code", InvalidSampleCode);
    //                 recGD.SETRANGE("Bute No.", LotNo);
    //                 recGD.SETRANGE(Stage, VariantCode);
    //                 recGD.SETRANGE("Item No.", ItemNo);
    //                 recGD.SETRANGE("Temp Season Code", SeasonCode);
    //                 recGD.SETRANGE(Invalid, FALSE);
    //                 IF recGD.FINDSET THEN BEGIN
    //                     REPEAT
    //                         recGD.VALIDATE(Invalid, TRUE);
    //                         recGD.VALIDATE("Invalid User Id", USERID);
    //                         recGD.MODIFY;
    //                     UNTIL recGD.NEXT = 0;
    //                 END;
    //             END;
    //         TestType::"Physical Purity Determination":
    //             BEGIN
    //                 recPPD.RESET;
    //                 recPPD.SETCURRENTKEY("Sample Code", Invalid);
    //                 recPPD.SETRANGE("Sample Code", InvalidSampleCode);
    //                 recPPD.SETRANGE("Bute No.", LotNo);
    //                 recPPD.SETRANGE(Stage, VariantCode);
    //                 recPPD.SETRANGE("Item No.", ItemNo);
    //                 recPPD.SETRANGE("Temp Season Code", SeasonCode);
    //                 recPPD.SETRANGE(Invalid, FALSE);
    //                 IF recPPD.FINDSET THEN BEGIN
    //                     REPEAT
    //                         recPPD.VALIDATE(Invalid, TRUE);
    //                         recPPD.VALIDATE("Invalid User Id", USERID);
    //                         recPPD.MODIFY;
    //                     UNTIL recPPD.NEXT = 0;
    //                 END;
    //             END;
    //         TestType::"Moisture Determination":
    //             BEGIN
    //                 recMD.RESET;
    //                 recMD.SETCURRENTKEY("Sample Code", Invalid);
    //                 recMD.SETRANGE("Sample Code", InvalidSampleCode);
    //                 recMD.SETRANGE("Bute No.", LotNo);
    //                 recMD.SETRANGE(Stage, VariantCode);
    //                 recMD.SETRANGE("Item No.", ItemNo);
    //                 recMD.SETRANGE("Temp Season Code", SeasonCode);
    //                 recMD.SETRANGE(Invalid, FALSE);
    //                 IF recMD.FINDSET THEN BEGIN
    //                     REPEAT
    //                         recMD.VALIDATE(Invalid, TRUE);
    //                         recMD.VALIDATE("Invalid User Id", USERID);
    //                         recMD.MODIFY;
    //                     UNTIL recMD.NEXT = 0;
    //                 END;
    //             END;
    //         TestType::"Vigour Test":
    //             BEGIN
    //                 recVT.RESET;
    //                 recVT.SETCURRENTKEY("Sample Code", Invalid);
    //                 recVT.SETRANGE("Sample Code", InvalidSampleCode);
    //                 recVT.SETRANGE("Bute No.", LotNo);
    //                 recVT.SETRANGE(Stage, VariantCode);
    //                 recVT.SETRANGE("Item No.", ItemNo);
    //                 recVT.SETRANGE("Temp Season Code", SeasonCode);
    //                 recVT.SETRANGE(Invalid, FALSE);
    //                 IF recVT.FINDSET THEN BEGIN
    //                     REPEAT
    //                         recVT.VALIDATE(Invalid, TRUE);
    //                         recVT.VALIDATE("Invalid User Id", USERID);
    //                         recVT.MODIFY;
    //                     UNTIL recVT.NEXT = 0;
    //                 END;
    //             END;
    //     END;
    // end;

    // local procedure "---------For QC Result-----------"()
    // begin
    // end;

    // // [Scope('Internal')]
    // procedure CalculateResult(TVariety: Code[20]; TParameter: Option " ","Genetic Pure Plants %","Self Plant %","Off Type Plant %","Positive for CRY 1AC %","Positive for CRY 2AB %","Normal Seed Lings","Pure Seed %","Inert Matter %","Cut Seed %","Other Crop Seed","Objectionable Weed Seed","Insect Damage %","Other Disting. Seed","Vigour Test","Vapour Proof %","Non-Vapour Proof %"; PercentTobeChecked: Decimal; var ResultVar: Boolean)
    // var
    //     recVWTD: Record "Variety wise Test Declaration";
    // begin
    //     ResultVar := FALSE;
    //     recVWTD.RESET;
    //     IF recVWTD.GET(TVariety, TParameter) THEN BEGIN
    //         CASE recVWTD."Parameter Value Calc." OF
    //             recVWTD."Parameter Value Calc."::"<":
    //                 IF PercentTobeChecked < recVWTD.Value THEN
    //                     ResultVar := TRUE;
    //             recVWTD."Parameter Value Calc."::"<=":
    //                 IF PercentTobeChecked <= recVWTD.Value THEN
    //                     ResultVar := TRUE;
    //             recVWTD."Parameter Value Calc."::"=":
    //                 IF PercentTobeChecked = recVWTD.Value THEN
    //                     ResultVar := TRUE;
    //             recVWTD."Parameter Value Calc."::">":
    //                 IF PercentTobeChecked > recVWTD.Value THEN
    //                     ResultVar := TRUE;
    //             recVWTD."Parameter Value Calc."::">=":
    //                 IF PercentTobeChecked >= recVWTD.Value THEN
    //                     ResultVar := TRUE;
    //         END;
    //     END ELSE
    //         ERROR('Please create variety wise test declaration for item no. %1 & Test Parameter %2, Looks like you havenot made it yet.', TVariety, TParameter);
    // end;

    local procedure "---------Creating Reservation Entry for Transfer Order-----------"()
    begin
    end;

    // [Scope('Internal')]
    procedure CreateReservationEntry(RecTransferHeader: Record "Transfer Header"; RecTransferLine: Record "Transfer Line"; CaseNo: Option Zero,One)
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntryNo: Integer;
    begin
        //ReservationEntry for Lot Tracking
        CLEAR(ReservationEntryNo);
        ReservationEntry.RESET;
        IF NOT ReservationEntry.FINDLAST THEN
            ReservationEntryNo := ReservationEntry."Entry No." + 1
        ELSE
            ReservationEntryNo := ReservationEntry."Entry No." + 1;

        ReservationEntry.RESET;
        ReservationEntry.INIT;
        ReservationEntry."Entry No." := ReservationEntryNo;
        ReservationEntry."Item No." := RecTransferLine."Item No.";
        IF CaseNo = CaseNo::Zero THEN BEGIN
            ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"2";
            ReservationEntry.Quantity := RecTransferLine.Quantity;
            ReservationEntry."Quantity (Base)" := RecTransferLine.Quantity;
            ReservationEntry."Qty. to Handle (Base)" := RecTransferLine.Quantity;
            ReservationEntry."Qty. to Invoice (Base)" := RecTransferLine.Quantity;
            ReservationEntry."Location Code" := RecTransferHeader."Transfer-to Code";
            ReservationEntry."Source Subtype" := 1;
            ReservationEntry."Expected Receipt Date" := RecTransferHeader."Posting Date";
            ReservationEntry.Positive := TRUE;
        END ELSE
            IF CaseNo = CaseNo::One THEN BEGIN
                ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"3";
                ReservationEntry.Quantity := RecTransferLine.Quantity * -1;
                ReservationEntry."Quantity (Base)" := RecTransferLine.Quantity * -1;
                ReservationEntry."Qty. to Handle (Base)" := RecTransferLine.Quantity * -1;
                ReservationEntry."Qty. to Invoice (Base)" := RecTransferLine.Quantity * -1;
                ReservationEntry."Location Code" := RecTransferHeader."Transfer-from Code";
                ReservationEntry."Source Subtype" := 0;
                ReservationEntry."Shipment Date" := RecTransferHeader."Posting Date";
                ReservationEntry.Positive := FALSE;
            END;
        //ReservationEntry."Lot No." := RecTransferLine."Bute No.";
        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
        ReservationEntry."Creation Date" := TODAY;
        ReservationEntry."Source Type" := 5741;
        ReservationEntry."Source ID" := RecTransferHeader."No.";
        ReservationEntry."Source Ref. No." := RecTransferLine."Line No.";
        ReservationEntry."Created By" := USERID;
        ReservationEntry."Qty. per Unit of Measure" := RecTransferLine."Qty. per Unit of Measure";
        ReservationEntry."Variant Code" := RecTransferLine."Variant Code";
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry.INSERT;
    end;

    // local procedure "---------For Fetching Sales Price-----------"()
    // begin
    // end;

    // // [Scope('Internal')]
    // procedure FetchingSalesPrice(SalesCode: Text; SalesType: Option Customer,"Customer Price Group","All Customers",Campaign; ItemNo: Text; Date: Date; UnitofMeasureCode: Text): Decimal
    // var
    //     recSalesPrice: Record "Sales Price";
    // begin
    //     recSalesPrice.RESET;
    //     recSalesPrice.SETCURRENTKEY("Sales Code", "Sales Type", "Item No.", "Starting Date", "Ending Date", "Unit of Measure Code");
    //     recSalesPrice.SETRANGE("Sales Type", recSalesPrice."Sales Type"::"Customer Price Group");
    //     recSalesPrice.SETRANGE("Sales Code", SalesCode);
    //     recSalesPrice.SETRANGE("Item No.", ItemNo);
    //     recSalesPrice.SETFILTER("Starting Date", '%1|%2', 0D, Date);
    //     recSalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, Date);
    //     recSalesPrice.SETFILTER("Unit of Measure Code", '%1|%2', UnitofMeasureCode, '');
    //     IF recSalesPrice.FINDFIRST THEN
    //         EXIT(recSalesPrice."Unit Price");
    // end;

    local procedure "---------For Lot No. Infor-----------"()
    begin
    end;

    // [Scope('Internal')]
    // procedure CreateLotNoInfo(Trec50007: Record "Process Header")
    // var
    //     recLotNoInformation: Record "Lot No. Information";
    //     Trec50008: Record "Process Line";
    // begin
    //     Trec50008.RESET;
    //     Trec50008.SETCURRENTKEY("Document No.");
    //     Trec50008.SETRANGE("Document No.", Trec50007."No.");
    //     IF Trec50008.FINDSET THEN BEGIN
    //         REPEAT
    //             recLotNoInformation.RESET;
    //             recLotNoInformation.INIT;
    //             recLotNoInformation."Item No." := Trec50008."Packed Item Code";
    //             recLotNoInformation."Variant Code" := Trec50007."To Stage";
    //             recLotNoInformation."Lot No." := Trec50008."Marketing Lot No.";
    //             recLotNoInformation."Test Quality" := recLotNoInformation."Test Quality"::Good;
    //             recLotNoInformation."Location Code" := Trec50007.Location;
    //             recLotNoInformation."Expiry Date" := Trec50008."Expiry Date";
    //             recLotNoInformation."RO No." := Trec50008."Released Order No.";
    //             recLotNoInformation."Packing Date" := TODAY;
    //             recLotNoInformation."Process Transfer No." := documentno;
    //             recLotNoInformation.Season := rec50007.Season;//LK
    //             recLotNoInformation."Prefix No." := Trec50008."Prefix No.";//LK
    //             recLotNoInformation.INSERT;
    //         UNTIL Trec50008.NEXT = 0;
    //     END;
    // end;

    local procedure "---------For User Permission Location Code 2-----------"()
    begin
    end;

    // [Scope('Internal')]
    procedure FetchAllLocationsOfUser(var Var_Locations: Text)
    begin
        recUL.RESET;
        recUL.SETCURRENTKEY("User ID");
        recUL.SETRANGE("User ID", USERID);
        IF recUL.FINDSET THEN BEGIN
            REPEAT
                Var_Locations := STRSUBSTNO('%1|%2', recUL."Location Code", Var_Locations);
            UNTIL recUL.NEXT = 0;
            IF Var_Locations = '|' THEN
                ERROR('Please Create User Location Master for user %1 & assign its Locations.', USERID);
            Var_Locations += '%1';
        END ELSE
            ERROR('User Location Setup with User Id %1 doesnot found.', USERID);
    end;

    //[Scope('Internal')]
    procedure UserLocationUserPermission(var CanInsert: Boolean)
    begin
        IF CanInsert <> TRUE THEN
            ERROR(ContactAdminText003);
    end;

    // [Scope('Internal')]
    procedure UserLocationUserPermissionCanViewForPosted(var CanView: Boolean)
    begin
        IF CanView <> TRUE THEN
            ERROR(ContactAdminText003);
    end;

    // [Scope('Internal')]
    // procedure UserLocationWiseCanViewCanInsertDNULW(var CanView: Boolean; var CanInsert: Boolean; var Var_Locations: Text; PageDetails: Option " ","Crop Master","Crop Stage Master","Season Master","Item Group Master","Geographical Setup Master","Zone Master","Taluka Master","Region Master","State Master","Grower Master","District Master","Parent Seed Master","Lot Range Master","Party Master",Got,BtElisa,GD,PPD,MD,VT,"QC Result Declaration",Retest,"Land Lease Master","RIB Master","Gate Entry Inward","Gate Entry Outward",VWQP,"Evaluation Project","Evaluation Worksheet")
    // begin
    //     //MESSAGE('%1',PageDetails);
    //     IF Var_Locations = '' THEN
    //         ERROR(ContactAdminText003);
    //     recUL.RESET;
    //     recUL.SETCURRENTKEY("User ID");
    //     recUL.SETRANGE("User ID", USERID);
    //     IF recUL.FINDSET THEN BEGIN
    //         REPEAT
    //             CASE PageDetails OF
    //                 PageDetails::" ":
    //                     BEGIN
    //                         CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Crop Master":
    //                     BEGIN
    //                         IF recUL."View Crop Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Crop Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Crop Stage Master":
    //                     BEGIN
    //                         IF recUL."View Crop Stage Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Crop Stage Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Season Master":
    //                     BEGIN
    //                         IF recUL."View Season Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Season Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Item Group Master":
    //                     BEGIN
    //                         IF recUL."View Item Group Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Item Group Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Geographical Setup Master":
    //                     BEGIN
    //                         IF recUL."View Geographical Setup" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Geographical Setup" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Zone Master":
    //                     BEGIN
    //                         IF recUL."View Zone Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Zone Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Taluka Master":
    //                     BEGIN
    //                         IF recUL."View Taluka Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Taluka Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Region Master":
    //                     BEGIN
    //                         IF recUL."View Region Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Region Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"State Master":
    //                     BEGIN
    //                         IF recUL."View State Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."State Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"District Master":
    //                     BEGIN
    //                         IF recUL."View District Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."District Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Grower Master":
    //                     BEGIN
    //                         IF recUL."View Grower Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Grower Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Parent Seed Master":
    //                     BEGIN
    //                         IF recUL."View Parent Seed Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Parent Seed Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Party Master":
    //                     BEGIN
    //                         IF recUL."View Party Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Party Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::Got:
    //                     BEGIN
    //                         IF recUL."View Got Testing Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Got Testing Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::BtElisa:
    //                     BEGIN
    //                         IF recUL."View BT Testing Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."BT Testing Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::GD:
    //                     BEGIN
    //                         IF recUL."View Germination Determination" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Germination Determination" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::PPD:
    //                     BEGIN
    //                         IF recUL."View Physical Purity Deter." = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Physical Purity Determination" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::MD:
    //                     BEGIN
    //                         IF recUL."View Moisture Determination" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Moisture Determination" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::VT:
    //                     BEGIN
    //                         IF recUL."View Vigour Test" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Vigour Test" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"QC Result Declaration":
    //                     BEGIN
    //                         IF recUL."View QC Result Declaration" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."QC Result Declaration" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::Retest:
    //                     BEGIN
    //                         IF recUL."View Retest Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Retest Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Land Lease Master":
    //                     BEGIN
    //                         IF recUL."View Land Lease" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Land Lease" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"RIB Master":
    //                     BEGIN
    //                         IF recUL."View RIB" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.RIB = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Gate Entry Inward":
    //                     BEGIN
    //                         IF recUL."View Gate Entry Inward" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Gate Entry Inward" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Gate Entry Outward":
    //                     BEGIN
    //                         IF recUL."View Gate Entry Outward" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Gate Entry Outward" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::VWQP:
    //                     BEGIN
    //                         IF recUL."View VWQP" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.VWQP = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Evaluation Project":
    //                     BEGIN
    //                         IF recUL."View Evaluation Project" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Evaluation Project" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Evaluation Worksheet":
    //                     BEGIN
    //                         IF recUL."View Evaluation Worksheet" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Evaluation Worksheet" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Lot Range Master":
    //                     BEGIN
    //                         IF recUL."View Lot Range Master" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Lot Range Master" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //             END;
    //         UNTIL recUL.NEXT = 0;
    //     END;
    // end;

    // [Scope('Internal')]
    // procedure UserLocationWiseCanViewCanInsertDULW(var CanView: Boolean; var CanInsert: Boolean; var Var_Locations: Text; PageDetails: Option " ","Process Transfer","Posted Process Transfer",BSIO,"Posted BSIO",FSIO,"Posted FSIO","Seed Arrival","Posted Seed Arrival","Planting List","Posted Planting List","Hybrid Seed Arrival","Posted hybrid Seed Arrival","Inspection I","Posted Inspection I","Inspection II","Posted Inspection II","Inspection III","Posted Inspection III","Inspection IV","Posted Inspection IV","Inspection QC","Posted Inspection QC",Blend,"Posted Blend","Organizer Arrival","Posted Organizer Arrival","Organizer Process Transfer","Posted Organizer Process Transfer","Org Outward Gate Entry","Posted Org Outward Gate Entry","Marketing Indent","Posted Marketing Indent","Delivery Order","Posted Delivery Order","Hybrid Sales Order","Posted Hybrid Sales Order.","Non Seed Indent","Posted Non Seed Indent",RVD,"Posted RVD","Sucker Receipt","Posted Sucker Receipt","Tissue Culture PT","Posted Tissue Culture PT","Tissue Culture Contamination ","Posted Tissue Culture Contamination","Posted Seed Arrival FSIO Rece","Posted Seed Arrival Hybrid Rec","Posted Seed Arrival FSIO Invoi","Posted Seed Arrival Hybrid Inv",PO,"Transfer Order",SO,WO,Truck,TC)
    // begin
    //     //MESSAGE('%1',PageDetails);
    //     IF Var_Locations = '' THEN
    //         ERROR(ContactAdminText003);
    //     recUL.RESET;
    //     recUL.SETCURRENTKEY("User ID");
    //     recUL.SETRANGE("User ID", USERID);
    //     IF recUL.FINDSET THEN BEGIN
    //         REPEAT
    //             CASE PageDetails OF
    //                 PageDetails::" ":
    //                     BEGIN
    //                         CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Process Transfer":
    //                     BEGIN
    //                         IF recUL."View Process Header" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Process Header" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Process Transfer":
    //                     BEGIN
    //                         IF recUL."View Process Invoice Header" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Process Invoice Header" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::BSIO:
    //                     BEGIN
    //                         IF recUL."View BSIO" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.BSIO = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted BSIO":
    //                     BEGIN
    //                         IF recUL."View Posted BSIO" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.BSIO = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::FSIO:
    //                     BEGIN
    //                         IF recUL."View FSIO" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.FSIO = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted FSIO":
    //                     BEGIN
    //                         IF recUL."View Posted FSIO" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.FSIO = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Seed Arrival":
    //                     BEGIN
    //                         IF recUL."View Seed Arrival FSIO" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Seed Arrival FSIO" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Seed Arrival":
    //                     BEGIN
    //                         IF recUL."View Posted Seed Arrival" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Seed Arrival FSIO" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Planting List":
    //                     BEGIN
    //                         IF recUL."View Planting List" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Planting List" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Planting List":
    //                     BEGIN
    //                         IF recUL."View Posted Planting List" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Planting List" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Hybrid Seed Arrival":
    //                     BEGIN
    //                         IF recUL."View Seed Arrival Hybrid" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Seed Arrival Hybrid" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted hybrid Seed Arrival":
    //                     BEGIN
    //                         IF recUL."View Posted Hybrid Seed Arrvl" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Seed Arrival Hybrid" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Inspection I":
    //                     BEGIN
    //                         IF recUL."View Inspection I" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection I" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Inspection I":
    //                     BEGIN
    //                         IF recUL."View Posted Inspection I" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection I" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Inspection II":
    //                     BEGIN
    //                         IF recUL."View Inspection II" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection II" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Inspection II":
    //                     BEGIN
    //                         IF recUL."View Posted Inspection II" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection II" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Inspection III":
    //                     BEGIN
    //                         IF recUL."View Inspection III" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection III" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Inspection III":
    //                     BEGIN
    //                         IF recUL."View Posted Inspection III" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection III" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Inspection IV":
    //                     BEGIN
    //                         IF recUL."View Inspection IV" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection IV" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Inspection IV":
    //                     BEGIN
    //                         IF recUL."View Posted Inspection IV" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection IV" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Inspection QC":
    //                     BEGIN
    //                         IF recUL."View Inspection QC" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection QC" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Inspection QC":
    //                     BEGIN
    //                         IF recUL."View Posted Inspection QC" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Inspection QC" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::Blend:
    //                     BEGIN
    //                         IF recUL."View Blend" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.Blend = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Blend":
    //                     BEGIN
    //                         IF recUL."View Posted Blend" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.Blend = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Organizer Arrival":
    //                     BEGIN
    //                         IF recUL."View Organizer Arrival" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Organizer Arrival" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Organizer Arrival":
    //                     BEGIN
    //                         IF recUL."View Posted Org. Arrival" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Organizer Arrival" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Organizer Process Transfer":
    //                     BEGIN
    //                         IF recUL."View Organizer Process Trnsfr" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Organizer Process Transfer" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Organizer Process Transfer":
    //                     BEGIN
    //                         IF recUL."View Posted Org. Process Trnfr" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Organizer Process Transfer" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Org Outward Gate Entry":
    //                     BEGIN
    //                         IF recUL."View Org Gate Entry Outward" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Org Gate Entry Outward" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Org Outward Gate Entry":
    //                     BEGIN
    //                         IF recUL."View Posted Org. OGE" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Org Gate Entry Outward" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Marketing Indent":
    //                     BEGIN
    //                         IF recUL."View Marketing Indent" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Marketing Indent" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Marketing Indent":
    //                     BEGIN
    //                         IF recUL."View Posted Marketing Indent" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Marketing Indent" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Delivery Order":
    //                     BEGIN
    //                         IF recUL."View Delivery Order" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Delivery Order" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Delivery Order":
    //                     BEGIN
    //                         IF recUL."View Posted Delivery Order" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Delivery Order" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Hybrid Sales Order":
    //                     BEGIN
    //                         IF recUL."View Hybrid Sales Order" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Hybrid Sales Order" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Hybrid Sales Order.":
    //                     BEGIN
    //                         IF recUL."View Posted Hybrid Sales Ordr" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Hybrid Sales Order" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Non Seed Indent":
    //                     BEGIN
    //                         IF recUL."View Non Seed Indent" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Non Seed Indent" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Non Seed Indent":
    //                     BEGIN
    //                         IF recUL."View Posted Non Seed Indent" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Non Seed Indent" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::RVD:
    //                     BEGIN
    //                         IF recUL."View RVD" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.RVD = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted RVD":
    //                     BEGIN
    //                         IF recUL."View Posted RVD" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.RVD = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Sucker Receipt":
    //                     BEGIN
    //                         IF recUL."View Sucker Receipt" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Sucker Receipt" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Sucker Receipt":
    //                     BEGIN
    //                         IF recUL."View Posted Sucker Receipt" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Sucker Receipt" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Tissue Culture PT":
    //                     BEGIN
    //                         IF recUL."View Tissue Culture PT" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Tissue Culture PT" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Tissue Culture PT":
    //                     BEGIN
    //                         IF recUL."View Posted Tissue Culture PT" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Tissue Culture PT" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Tissue Culture Contamination ":
    //                     BEGIN
    //                         IF recUL."View Tissue Culture Conta." = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Tissue Culture Conta." = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Posted Tissue Culture Contamination":
    //                     BEGIN
    //                         IF recUL."View Posted Tissue Culture Ct." = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Tissue Culture Conta." = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::PO:
    //                     BEGIN
    //                         IF recUL."View Purchase Order" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Create Purchase Order" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::"Transfer Order":
    //                     BEGIN
    //                         IF recUL."View Transfer Order" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Transfer Order" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::WO:
    //                     BEGIN
    //                         IF recUL."View Work Order" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Work Order" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::Truck:
    //                     BEGIN
    //                         IF recUL."Truck Settlement" = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL."Truck Settlement" = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //                 PageDetails::TC:
    //                     BEGIN
    //                         IF recUL.TC = TRUE THEN
    //                             CanView := TRUE;
    //                         IF CanView = TRUE THEN
    //                             IF recUL.TC = TRUE THEN
    //                                 CanInsert := TRUE;
    //                     END;
    //             END;
    //         UNTIL recUL.NEXT = 0;
    //     END;
    // end;

    // [Scope('Internal')]
    // procedure UserLocation(LocationCode: Code[20])
    // var
    //     LocationOne: Boolean;
    //     LocationTwo: Boolean;
    //     CanAccessAllLocation: Boolean;
    // begin
    //     IF LocationCode <> '' THEN BEGIN
    //         //UserPermission
    //         LocationOne := FALSE;
    //         //  LocationTwo := FALSE;
    //         //  CanAccessAllLocation := FALSE;
    //         recUL.RESET;
    //         recUL.SETCURRENTKEY("User ID");
    //         recUL.SETRANGE("User ID", USERID);
    //         IF recUL.FINDSET THEN BEGIN
    //             REPEAT
    //                 IF LocationCode = recUL."Location Code" THEN
    //                     LocationOne := TRUE;
    //             //      IF LocationCode = recUL."Location Code 2" THEN
    //             //        LocationTwo := TRUE;
    //             //      IF recUL."Can Access All Location" = TRUE THEN
    //             //        CanAccessAllLocation := TRUE;
    //             UNTIL recUL.NEXT = 0;
    //         END;

    //         IF (LocationOne <> TRUE) THEN
    //             //  IF (LocationOne <> TRUE) AND (LocationTwo <> TRUE) AND (CanAccessAllLocation <> TRUE) THEN
    //             ERROR('You donot have permission to select Location %1.Please Contact your System Admin.', LocationCode);
    //     END;
    // end;

    // local procedure "-------------------------------For Sending Mail from Requistion Worksheet-----------------"()
    // begin
    // end;

    // // [Scope('Internal')]
    // procedure RequisitionWorksheetEmailDetails(PurchaseHeaderNos: Code[180])
    // begin
    //     //Nakul@PBS
    //     WHILE (STRPOS(PurchaseHeaderNos, '|') <> 0) DO BEGIN
    //         RequisitionWorksheetSendMail(DELSTR(PurchaseHeaderNos, STRPOS(PurchaseHeaderNos, '|')));
    //         PurchaseHeaderNos := DELSTR(PurchaseHeaderNos, 1, STRPOS(PurchaseHeaderNos, '|'));
    //     END;
    //     IF PurchaseHeaderNos <> '' THEN BEGIN
    //         RequisitionWorksheetSendMail(PurchaseHeaderNos);
    //     END;
    //     //Nakul@PBS
    // end;

    // // [Scope('Internal')]
    // procedure RequisitionWorksheetSendMail(PurchaseHeaderNo: Code[20])
    // var
    //     PurchaseHeader: Record "Purchase Header";
    //     PurchaseLine: Record "Purchase Line";
    //     Vendor: Record Vendor;
    //     // SMTPMailSetup: Record "SMTP Mail Setup";
    //     SMTPMailSetup: Record "Email Account";
    // // SMTP: Codeunit "SMTP Mail";//PBS KK
    // begin
    //     PurchaseHeader.RESET;
    //     PurchaseHeader.SETCURRENTKEY("No.");
    //     PurchaseHeader.SETRANGE("No.", PurchaseHeaderNo);
    //     IF PurchaseHeader.FINDFIRST THEN BEGIN
    //         Vendor.RESET;
    //         Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
    //         Vendor.TESTFIELD("E-Mail");
    //     END;
    //     //PBS KK
    //     // IF SMTPMailSetup.GET THEN BEGIN
    //     //     SMTP.CreateMessage('Ajeet Seeds Pvt. Ltd.', SMTPMailSetup."User ID", Vendor."E-Mail", 'Email Regarding Item Rates.', '', TRUE);//This PBS kanhaiya
    //     //     SMTP.AppendBody('Dear Sir,<br />');
    //     //     SMTP.AppendBody('Please Send Your Quotation for Below Given Items.<br />');
    //     //     SMTP.AppendBody('Please Mentioned Rates Inclusive or Exclusive of GST with Percentage of GST.<br /><br />');
    //     //     SMTP.AppendBody('<!DOCTYPE html><html><body><table style="border-collapse: separate;border-spacing: 0;color: #4a4a4d;font: 14px/1.4 "Helvetica Neue", Helvetica, Arial, sans-serif; padding-left:10px;">' +
    //     //                     '<thead style="background: #395870;background: linear-gradient(#49708f, #293f50);color: #fff;font-size: 11px;text-transform: uppercase;"><tr>' +
    //     //                     '<th scope="col" style="border-top-left-radius: 5px;text-align: left;padding: 10px 15px;vertical-align: middle;">Item Name</th>' +
    //     //                     '<th scope="col" style="border-top-right-radius: 5px;text-align: left;padding: 10px 15px;vertical-align: middle;">Quantity</th>' +
    //     //                     '</tr></thead><tbody>');

    //     //     PurchaseLine.RESET;
    //     //     PurchaseLine.SETCURRENTKEY("Document No.", "Document Type", "Line No.");
    //     //     PurchaseLine.SETRANGE("Document No.", PurchaseHeaderNo);
    //     //     PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
    //     //     IF PurchaseLine.FINDSET THEN BEGIN
    //     //         REPEAT
    //     //             PurchaseLine.CALCFIELDS("Item Name");
    //     //             SMTP.AppendBody('<tr>' +
    //     //                             '<td style="border-left: 1px solid #cecfd5;border-bottom: 1px solid #cecfd5;border-right: 1px solid #cecfd5;padding: 10px 15px;vertical-align: middle;color: #395870;display: block;" ><strong>' + PurchaseLine."Item Name" +
    //     //                             '</strong></td>' +
    //     //                             '<td style="border-left: 1px solid #cecfd5;border-bottom: 1px solid #cecfd5;border-right: 1px solid #cecfd5;padding: 10px 15px;vertical-align: middle;text-align: right;" >' + FORMAT(PurchaseLine.Quantity) + '</td>' +
    //     //                             '</tr>');
    //     //         UNTIL PurchaseLine.NEXT = 0;
    //     //     END;
    //     //     SMTP.AppendBody('</tbody></table></body></html><br /><br /><br />');
    //     //     SMTP.AppendBody('Thanks & Regards,<br />');
    //     //     SMTP.AppendBody('(Team - Ajeet Seeds Pvt. Ltd.)<br />');
    //     //     SMTP.AppendBody('<a href="https://www.ajeetseed.co.in/">www.ajeetseed.co.in</a><br />');
    //     //     SMTP.AppendBody('Contact: 02431-251444/45, 09922933999');
    //     //     //SMTP.AddCC('mithilesh@pristinebs.com');
    //     //     SMTP.Send;
    //     //     MESSAGE('Mail Send Successfully!');
    //     // END;
    // end;

    local procedure "------------------------------App to Navision App String Conversion------------------"()
    begin
    end;

    // [Scope('Internal')]
    procedure AppStringToDate(DateInString: Text): Date
    var
        day: Text;
        month: Text;
        year: Text;
        ReturnedDate: Date;
    begin
        //DateInString := '2020-24-07';
        //2020-07-24T00:00:00
        //YYYY-MM-DDT00:00:00 Format currently running dont changed it
        CLEAR(day);
        CLEAR(month);
        CLEAR(year);
        IF DateInString = '01-01-1900' THEN
            EXIT(0D);
        //day := FORMAT(DELSTR(DateInString,3));
        //month := FORMAT(COPYSTR(DateInString,4,2));
        //year := FORMAT(COPYSTR(DateInString,7,4));
        day := FORMAT(COPYSTR(DateInString, 9, 2));
        month := FORMAT(COPYSTR(DateInString, 6, 2));
        year := FORMAT(COPYSTR(DateInString, 1, 4));
        IF (day <> '') AND (month <> '') AND (year <> '') THEN BEGIN
            EVALUATE(ReturnedDate, STRSUBSTNO('%1-%2-%3', day, month, year));
            EXIT(ReturnedDate);
        END;
        EXIT(0D);
    end;

    // [Scope('Internal')]
    procedure AppStringToDate2(DateInString: Text): Text
    var
        day: Text;
        month: Text;
        year: Text;
        ReturnedDate: Date;
    begin
        //YYYY-MM-DD Format currently running dont changed it
        CLEAR(day);
        CLEAR(month);
        CLEAR(year);
        IF DateInString = '01-01-1900' THEN
            EXIT('');
        //day := FORMAT(DELSTR(DateInString,3));
        //month := FORMAT(COPYSTR(DateInString,4,2));
        //year := FORMAT(COPYSTR(DateInString,7,4));
        day := FORMAT(COPYSTR(DateInString, 9, 2));
        month := FORMAT(COPYSTR(DateInString, 6, 2));
        year := FORMAT(COPYSTR(DateInString, 1, 4));
        IF (day <> '') AND (month <> '') AND (year <> '') THEN BEGIN
            EXIT(STRSUBSTNO('%1-%2-%3', day, month, year));
        END;
        EXIT('');
    end;

    local procedure "-----------------------------Remaining No. of Bags-------------------------"()
    begin
    end;

    // [Scope('Internal')]
    procedure RemainingBags(Var_ItemNo: Code[20]; Var_LocationCode: Code[20]; Var_VariantCode: Code[20]; Var_ButeNo: Code[20]): Decimal
    var
        ItemLedgerEntryPositive: Record "Item Ledger Entry";
        ItemLedgerEntryNegative: Record "Item Ledger Entry";
        PositiveBags: Decimal;
        NegativeBags: Decimal;
        PositiveQty: Decimal;
        NegativeQty: Decimal;
    begin
        IF (Var_ItemNo = '') OR (Var_LocationCode = '') OR (Var_VariantCode = '') OR (Var_ButeNo = '') THEN
            ERROR('Unable to fetch details of Remaining No. of Bags');
        CLEAR(PositiveBags);
        CLEAR(NegativeBags);
        ItemLedgerEntryPositive.RESET;
        ItemLedgerEntryPositive.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Entry Type", "Location Code");
        ItemLedgerEntryPositive.SETRANGE("Item No.", Var_ItemNo);
        ItemLedgerEntryPositive.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryPositive."Entry Type"::"Positive Adjmt.", ItemLedgerEntryPositive."Entry Type"::Purchase, ItemLedgerEntryPositive."Entry Type"::Transfer,
                                                                  ItemLedgerEntryPositive."Entry Type"::Sale);
        ItemLedgerEntryPositive.SETRANGE("Location Code", Var_LocationCode);
        ItemLedgerEntryPositive.SETRANGE("Variant Code", Var_VariantCode);
        ItemLedgerEntryPositive.SETRANGE("Lot No.", Var_ButeNo);
        IF ItemLedgerEntryPositive.FINDSET THEN BEGIN
            REPEAT
                IF (ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::" ") AND (ItemLedgerEntryPositive."Entry Type" <> ItemLedgerEntryPositive."Entry Type"::Transfer) THEN BEGIN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                    PositiveQty += ItemLedgerEntryPositive.Quantity;
                END;
                IF (ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::" ") AND (ItemLedgerEntryPositive."Entry Type" = ItemLedgerEntryPositive."Entry Type"::Transfer) THEN BEGIN //ItemReclass
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                    PositiveQty += ItemLedgerEntryPositive.Quantity;
                END;
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Purchase Receipt" THEN BEGIN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                    PositiveQty += ItemLedgerEntryPositive.Quantity;
                END;
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Sales Return Receipt" THEN BEGIN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                    PositiveQty += ItemLedgerEntryPositive.Quantity;
                END;
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Transfer Receipt" THEN BEGIN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                    PositiveQty += ItemLedgerEntryPositive.Quantity;
                END;
            UNTIL ItemLedgerEntryPositive.NEXT = 0;
        END;
        ItemLedgerEntryNegative.RESET;
        ItemLedgerEntryNegative.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Entry Type", "Location Code");
        ItemLedgerEntryNegative.SETRANGE("Item No.", Var_ItemNo);
        ItemLedgerEntryNegative.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryNegative."Entry Type"::"Negative Adjmt.", ItemLedgerEntryNegative."Entry Type"::Sale, ItemLedgerEntryNegative."Entry Type"::Transfer,
                                                                  ItemLedgerEntryPositive."Entry Type"::Purchase);
        ItemLedgerEntryNegative.SETRANGE("Location Code", Var_LocationCode);
        ItemLedgerEntryNegative.SETRANGE("Variant Code", Var_VariantCode);
        ItemLedgerEntryNegative.SETRANGE("Lot No.", Var_ButeNo);
        IF ItemLedgerEntryNegative.FINDSET THEN BEGIN
            REPEAT
                IF (ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::" ") AND (ItemLedgerEntryNegative."Entry Type" <> ItemLedgerEntryNegative."Entry Type"::Transfer) THEN BEGIN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                    NegativeQty += ItemLedgerEntryNegative.Quantity;
                END;
                IF (ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::" ") AND (ItemLedgerEntryNegative."Entry Type" = ItemLedgerEntryNegative."Entry Type"::Transfer) THEN BEGIN //ItemReclass
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                    NegativeQty += ItemLedgerEntryNegative.Quantity;
                END;
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Purchase Return Shipment" THEN BEGIN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                    NegativeQty += ItemLedgerEntryNegative.Quantity;
                END;
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Sales Shipment" THEN BEGIN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                    NegativeQty += ItemLedgerEntryNegative.Quantity;
                END;
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Transfer Shipment" THEN BEGIN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                    NegativeQty += ItemLedgerEntryNegative.Quantity;
                END;
            UNTIL ItemLedgerEntryNegative.NEXT = 0;
        END;

        IF PositiveBags = NegativeBags THEN
            IF PositiveQty = NegativeQty THEN
                EXIT(0)
            ELSE
                EXIT(PositiveBags);

        EXIT(PositiveBags - NegativeBags);
    end;

    // [Scope('Internal')]
    procedure RemainingQtyForNotRegular(Var_ItemNo: Code[20]; Var_LocationCode: Code[20]; Var_VariantCode: Code[20]; Var_ButeNo: Code[20]): Decimal
    var
        ItemLedgerEntryPositive: Record "Item Ledger Entry";
        ItemLedgerEntryNegative: Record "Item Ledger Entry";
        PositiveBags: Decimal;
        NegativeBags: Decimal;
    begin
        IF (Var_ItemNo = '') OR (Var_LocationCode = '') OR (Var_VariantCode = '') OR (Var_ButeNo = '') THEN
            ERROR('Unable to fetch details of Remaining No. of Bags');
        CLEAR(PositiveBags);
        CLEAR(NegativeBags);
        ItemLedgerEntryPositive.RESET;
        ItemLedgerEntryPositive.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Entry Type", "Location Code");
        ItemLedgerEntryPositive.SETRANGE("Item No.", Var_ItemNo);
        ItemLedgerEntryPositive.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryPositive."Entry Type"::"Positive Adjmt.", ItemLedgerEntryPositive."Entry Type"::Purchase, ItemLedgerEntryPositive."Entry Type"::Transfer,
                                                                  ItemLedgerEntryPositive."Entry Type"::Sale);
        ItemLedgerEntryPositive.SETRANGE("Location Code", Var_LocationCode);
        ItemLedgerEntryPositive.SETRANGE("Variant Code", Var_VariantCode);
        ItemLedgerEntryPositive.SETRANGE("Lot No.", Var_ButeNo);
        IF ItemLedgerEntryPositive.FINDSET THEN BEGIN
            REPEAT
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::" " THEN
                    PositiveBags += ItemLedgerEntryPositive."Remaining Quantity";
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Purchase Receipt" THEN
                    PositiveBags += ItemLedgerEntryPositive."Remaining Quantity";
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Sales Return Receipt" THEN
                    PositiveBags += ItemLedgerEntryPositive."Remaining Quantity";
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Transfer Receipt" THEN
                    PositiveBags += ItemLedgerEntryPositive."Remaining Quantity";
            UNTIL ItemLedgerEntryPositive.NEXT = 0;
        END;
        ItemLedgerEntryNegative.RESET;
        ItemLedgerEntryNegative.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Entry Type", "Location Code");
        ItemLedgerEntryNegative.SETRANGE("Item No.", Var_ItemNo);
        ItemLedgerEntryNegative.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryNegative."Entry Type"::"Negative Adjmt.", ItemLedgerEntryNegative."Entry Type"::Sale, ItemLedgerEntryNegative."Entry Type"::Transfer,
                                                                  ItemLedgerEntryPositive."Entry Type"::Purchase);
        ItemLedgerEntryNegative.SETRANGE("Location Code", Var_LocationCode);
        ItemLedgerEntryNegative.SETRANGE("Variant Code", Var_VariantCode);
        ItemLedgerEntryNegative.SETRANGE("Lot No.", Var_ButeNo);
        IF ItemLedgerEntryNegative.FINDSET THEN BEGIN
            REPEAT
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::" " THEN
                    NegativeBags += ItemLedgerEntryNegative."Remaining Quantity";
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Purchase Return Shipment" THEN
                    NegativeBags += ItemLedgerEntryNegative."Remaining Quantity";
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Sales Shipment" THEN
                    NegativeBags += ItemLedgerEntryNegative."Remaining Quantity";
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Transfer Shipment" THEN
                    NegativeBags += ItemLedgerEntryNegative."Remaining Quantity";
            UNTIL ItemLedgerEntryNegative.NEXT = 0;
        END;
        EXIT(PositiveBags - NegativeBags);
    end;

    // [Scope('Internal')]
    procedure RemainingBagsWithoutLot(Var_ItemNo: Code[20]; Var_LocationCode: Code[20]; Var_VariantCode: Code[20]): Decimal
    var
        ItemLedgerEntryPositive: Record "Item Ledger Entry";
        ItemLedgerEntryNegative: Record "Item Ledger Entry";
        PositiveBags: Decimal;
        NegativeBags: Decimal;
    begin
        IF (Var_ItemNo = '') OR (Var_LocationCode = '') OR (Var_VariantCode = '') THEN
            ERROR('Unable to fetch details of Remaining No. of Bags');
        CLEAR(PositiveBags);
        CLEAR(ItemLedgerEntryPositive);
        ItemLedgerEntryPositive.RESET;
        ItemLedgerEntryPositive.SETCURRENTKEY("Item No.", "Variant Code", "Document Type", "Entry Type", "Location Code");
        ItemLedgerEntryPositive.SETRANGE("Item No.", Var_ItemNo);
        ItemLedgerEntryPositive.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryPositive."Entry Type"::"Positive Adjmt.", ItemLedgerEntryPositive."Entry Type"::Purchase, ItemLedgerEntryPositive."Entry Type"::Transfer,
                                                                  ItemLedgerEntryPositive."Entry Type"::Sale);
        ItemLedgerEntryPositive.SETFILTER("Document Type", '%1|%2|%3|%4', ItemLedgerEntryPositive."Document Type"::" ", ItemLedgerEntryPositive."Document Type"::"Purchase Receipt", ItemLedgerEntryPositive."Document Type"::"Sales Return Receipt",
                                                                  ItemLedgerEntryPositive."Document Type"::"Transfer Receipt");
        ItemLedgerEntryPositive.SETRANGE("Location Code", Var_LocationCode);
        ItemLedgerEntryPositive.SETRANGE("Variant Code", Var_VariantCode);
        IF ItemLedgerEntryPositive.FINDSET THEN BEGIN
            REPEAT
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::" " THEN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Purchase Receipt" THEN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Sales Return Receipt" THEN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
                IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Transfer Receipt" THEN
                    PositiveBags += ItemLedgerEntryPositive."No. of Bags/Pckt";
            UNTIL ItemLedgerEntryPositive.NEXT = 0;
        END;
        CLEAR(ItemLedgerEntryNegative);
        CLEAR(NegativeBags);
        ItemLedgerEntryNegative.RESET;
        ItemLedgerEntryNegative.SETCURRENTKEY("No. of Bags/Pckt");
        ItemLedgerEntryNegative.SETRANGE("Item No.", Var_ItemNo);
        ItemLedgerEntryNegative.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryNegative."Entry Type"::"Negative Adjmt.", ItemLedgerEntryNegative."Entry Type"::Sale, ItemLedgerEntryNegative."Entry Type"::Transfer,
                                                                  ItemLedgerEntryPositive."Entry Type"::Purchase);
        ItemLedgerEntryNegative.SETFILTER("Document Type", '%1|%2|%3|%4', ItemLedgerEntryNegative."Document Type"::" ", ItemLedgerEntryNegative."Document Type"::"Purchase Return Shipment", ItemLedgerEntryNegative."Document Type"::"Transfer Shipment",
                                                                  ItemLedgerEntryPositive."Document Type"::"Sales Shipment");
        ItemLedgerEntryNegative.SETRANGE("Location Code", Var_LocationCode);
        ItemLedgerEntryNegative.SETRANGE("Variant Code", Var_VariantCode);
        ItemLedgerEntryNegative.SETASCENDING("No. of Bags/Pckt", TRUE);
        IF ItemLedgerEntryNegative.FINDSET THEN BEGIN
            REPEAT
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::" " THEN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Purchase Return Shipment" THEN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Sales Shipment" THEN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
                IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Transfer Shipment" THEN
                    NegativeBags += ItemLedgerEntryNegative."No. of Bags/Pckt";
            UNTIL ItemLedgerEntryNegative.NEXT = 0;
        END;
        EXIT(PositiveBags - NegativeBags);
    end;

    local procedure "------------------------- NF -------------------------"()
    begin
    end;

    // [Scope('Internal')]
    // procedure GetSampleCode(SampleCodeType: Option " ",Regrading,RvdToClean; StartingDate: Date; var SampleCode: Code[20])
    // var
    //     LotRangeMaster: Record "Lot Range Master";
    // begin
    //     LotRangeMaster.RESET;
    //     LotRangeMaster.SETCURRENTKEY(Type, "Sample Code Type", "Starting Date", Blocked);
    //     LotRangeMaster.SETRANGE(Type, LotRangeMaster.Type::"Sample Code");
    //     LotRangeMaster.SETRANGE("Sample Code Type", SampleCodeType);
    //     LotRangeMaster.SETRANGE("Starting Date", 0D, StartingDate);
    //     LotRangeMaster.SETRANGE(Blocked, FALSE);
    //     IF LotRangeMaster.FINDFIRST THEN BEGIN
    //         LotRangeMaster.TESTFIELD("Increment-by No.");
    //         LotRangeMaster.TESTFIELD("Starting Date");
    //         LotRangeMaster.TESTFIELD("Starting No.");
    //         IF LotRangeMaster."Last No. Used" = '' THEN
    //             SampleCode := LotRangeMaster."Starting No."
    //         ELSE
    //             SampleCode := INCSTR(LotRangeMaster."Last No. Used");
    //         LotRangeMaster.VALIDATE("Last No. Used", SampleCode);
    //         LotRangeMaster.VALIDATE("Last DateTime Used", CURRENTDATETIME);
    //         LotRangeMaster.MODIFY(TRUE);
    //     END ELSE BEGIN
    //         ERROR('Sample Code Master not created yet for "Sample Code Type" %1, "Starting Date" %2 & blocked false.', SampleCodeType, StartingDate);
    //     END;
    // end;

    // [Scope('Internal')]
    // procedure UpdateHalfLeaveAndPaidLeaveAsPerLeaveStatusAndLeaveCodeWise(EmpID: Code[20]; Month: Integer; Year: Integer)
    // var
    //     DailyAttendanceDetails: Record "Daily Attendance Details";
    // begin
    //     IF (Year = 0) THEN
    //         ERROR('Year Filter must not be blank.');
    //     IF (Month = 0) THEN
    //         ERROR('Month Filter must not be blank.');
    //     //FunctionCode 101
    //     // status : Halfleave , leavvecode: LWP then "half paid" : true
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Half Paid", TRUE);
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Update By FC 101", TRUE);

    //     // status : Halfleave , leavvecode: LWP then paid : false
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL(Paid, FALSE);
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Update By FC 101", TRUE);

    //     // status : Halfleave , leavvecode: <>LWP then "half paid" : false
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETFILTER("Leave Code", '<>%1', 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Half Paid", FALSE);
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETFILTER("Leave Code", '<>%1', 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Update By FC 101", TRUE);

    //     // status : Halfleave , leavvecode: <>LWP then paid : true
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETFILTER("Leave Code", '<>%1', 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL(Paid, TRUE);
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::"Half Leave");
    //     DailyAttendanceDetails.SETFILTER("Leave Code", '<>%1', 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Update By FC 101", TRUE);

    //     // Status : Leave ,Leavecode : LWP then Paid : False
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::Leave);
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL(Paid, FALSE);
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::Leave);
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Update By FC 101", TRUE);

    //     // Status : Leave ,Leavecode : LWP then Half paid : False
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::Leave);
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Half Paid", FALSE);
    //     CLEAR(DailyAttendanceDetails);
    //     DailyAttendanceDetails.RESET;
    //     DailyAttendanceDetails.SETCURRENTKEY(Year, Month, EmpID, Status, "Leave Code", Closed);
    //     DailyAttendanceDetails.SETRANGE(Year, Year);
    //     DailyAttendanceDetails.SETRANGE(Month, Month);
    //     IF EmpID <> '' THEN
    //         DailyAttendanceDetails.SETRANGE(EmpID, EmpID);
    //     DailyAttendanceDetails.SETRANGE(Status, DailyAttendanceDetails.Status::Leave);
    //     DailyAttendanceDetails.SETRANGE("Leave Code", 'LWP');
    //     DailyAttendanceDetails.SETRANGE(Closed, FALSE);
    //     IF DailyAttendanceDetails.FINDSET(TRUE, TRUE) THEN
    //         DailyAttendanceDetails.MODIFYALL("Update By FC 101", TRUE);
    // end;

    // local procedure "------------- EVESUB -----------------"()
    // begin
    // end;

    // [EventSubscriber(ObjectType::Table, 50021, 'OnAfterValidateEvent', 'Rejection/PLD Area', false, false)]
    // local procedure OnValiRejectionPld(var Rec: Record "Inspection Line"; var xRec: Record "Inspection Line"; CurrFieldNo: Integer)
    // begin
    //     Rec.TESTFIELD("Season Code");
    //     Rec.TESTFIELD("Production Lot No.");
    //     UpdatePlantingRejectionPldNotCrossed(Rec);
    // end;

    // [EventSubscriber(ObjectType::Table, 50021, 'OnAfterValidateEvent', 'Not Crossed Area', false, false)]
    // local procedure OnValiNotCrossed(var Rec: Record "Inspection Line"; var xRec: Record "Inspection Line"; CurrFieldNo: Integer)
    // begin
    //     Rec.TESTFIELD("Season Code");
    //     Rec.TESTFIELD("Production Lot No.");
    //     UpdatePlantingRejectionPldNotCrossed(Rec);
    // end;

    // [EventSubscriber(ObjectType::Table, 50021, 'OnAfterValidateEvent', 'PLD Area', false, false)]
    // local procedure OnValiPldArea(var Rec: Record "Inspection Line"; var xRec: Record "Inspection Line"; CurrFieldNo: Integer)
    // begin
    //     Rec.TESTFIELD("Season Code");
    //     Rec.TESTFIELD("Production Lot No.");
    //     UpdatePlantingRejectionPldNotCrossed(Rec);
    // end;

    // [EventSubscriber(ObjectType::Table, 50021, 'OnAfterValidateEvent', 'Net Area', false, false)]
    // local procedure OnValiNetArea(var Rec: Record "Inspection Line"; var xRec: Record "Inspection Line"; CurrFieldNo: Integer)
    // var
    //     PlantingListLine: Record "Planting List Line";
    // begin
    //     Rec.TESTFIELD("Season Code");
    //     Rec.TESTFIELD("Production Lot No.");
    //     UpdatePlantingRejectionPldNotCrossed(Rec);
    // end;

    // local procedure UpdatePlantingRejectionPldNotCrossed(var Rec: Record "Inspection Line")
    // var
    //     InspectionLine: Record "Inspection Line";
    //     PlantingListLine: Record "Planting List Line";
    // begin
    //     CLEAR(PlantingListLine);
    //     PlantingListLine.RESET;
    //     PlantingListLine.SETCURRENTKEY("Production Lot No.", "Season Code");
    //     PlantingListLine.SETRANGE("Production Lot No.", Rec."Production Lot No.");
    //     PlantingListLine.SETRANGE("Season Code", Rec."Season Code");
    //     IF PlantingListLine.FINDFIRST THEN BEGIN
    //         PlantingListLine.VALIDATE("Rejected/PLD/Not Crossed", Rec."Rejection/PLD Area" + Rec."PLD Area" + Rec."Not Crossed Area");
    //         IF Rec."Net Area" = 0 THEN
    //             PlantingListLine.VALIDATE("PLD Area Rejection Inspec II", TRUE)
    //         ELSE
    //             PlantingListLine.VALIDATE("PLD Area Rejection Inspec II", FALSE);
    //         PlantingListLine.MODIFY(TRUE);
    //     END ELSE BEGIN
    //         ERROR('Unable to fetch details of Planting List with Production Lot No. %1.', Rec."Production Lot No.");
    //     END;
    // end;

    local procedure "===============LK==============="()
    begin
    end;

    // [Scope('Internal')]
    // procedure CheckGeographicalSetup(Zone: Text; State: Text; Region: Text; District: Text; Taluka: Text)
    // var
    //     GeographicalSetup: Record "Geographical Setup";
    // begin
    //     GeographicalSetup.RESET;
    //     GeographicalSetup.SETCURRENTKEY(Zone, State, Region, District, Taluka);
    //     GeographicalSetup.SETRANGE(Zone, Zone);
    //     GeographicalSetup.SETRANGE(State, State);
    //     GeographicalSetup.SETRANGE(Region, Region);
    //     GeographicalSetup.SETRANGE(District, District);
    //     GeographicalSetup.SETRANGE(Taluka, Taluka);
    //     GeographicalSetup.FINDFIRST;
    // end;

    //[Scope('Internal')]
    // procedure ModifyDateOnResults(ButteNo: Code[20]; SampleCode: Code[20]; Season: Code[20]; ItemNo: Code[20]; CropCode: Code[20]; SourceType: Option " ",Foundation,Hybrid; DateOfDividing: Date; BatchNo: Code[20]; GOT: Boolean)
    // var
    //     RecBT: Record "BT/Elisa Testing Master";
    //     RecSTLGer: Record "Germination Evaluation";
    //     RecMOI: Record "Moisture Determination";
    //     RecPHY: Record "Physical Purity Determination";
    //     RecVT: Record "Vigour Test";
    // begin
    //     IF GOT = TRUE THEN BEGIN
    //         RecBT.RESET;
    //         RecBT.SETCURRENTKEY("Bute No.", "Sample Code", "Temp Season Code", "Item No.", "Crop Code", "Source Type");
    //         RecBT.SETRANGE("Bute No.", ButteNo);
    //         RecBT.SETRANGE("Temp Season Code", Season);
    //         RecBT.SETRANGE("Item No.", ItemNo);
    //         RecBT.SETRANGE("Crop Code", CropCode);
    //         RecBT.SETRANGE("Source Type", SourceType);
    //         RecBT.SETRANGE(Invalid, FALSE);
    //         IF RecBT.FINDFIRST THEN BEGIN
    //             RecBT."Date of Dividng" := DateOfDividing;
    //             RecBT."Batch No" := BatchNo;
    //             RecBT.MODIFY;
    //         END;

    //     END ELSE BEGIN
    //         RecMOI.RESET;
    //         RecMOI.SETCURRENTKEY("Bute No.", "Sample Code", "Temp Season Code", "Item No.", "Crop Code", "Source Type");
    //         RecMOI.SETRANGE("Bute No.", ButteNo);
    //         RecMOI.SETRANGE("Temp Season Code", Season);
    //         RecMOI.SETRANGE("Item No.", ItemNo);
    //         RecMOI.SETRANGE("Crop Code", CropCode);
    //         RecMOI.SETRANGE("Source Type", SourceType);
    //         RecMOI.SETRANGE(Invalid, FALSE);
    //         IF RecMOI.FINDFIRST THEN BEGIN
    //             RecMOI."Date of Dividng" := DateOfDividing;
    //             RecMOI."Batch No" := BatchNo;
    //             RecMOI.MODIFY;
    //         END;

    //         RecPHY.RESET;
    //         RecPHY.SETCURRENTKEY("Bute No.", "Sample Code", "Temp Season Code", "Item No.", "Crop Code", "Source Type");
    //         RecPHY.SETRANGE("Bute No.", ButteNo);
    //         RecPHY.SETRANGE("Temp Season Code", Season);
    //         RecPHY.SETRANGE("Item No.", ItemNo);
    //         RecPHY.SETRANGE("Crop Code", CropCode);
    //         RecPHY.SETRANGE("Source Type", SourceType);
    //         RecPHY.SETRANGE(Invalid, FALSE);
    //         IF RecPHY.FINDFIRST THEN BEGIN
    //             RecPHY."Date of Dividng" := DateOfDividing;
    //             RecPHY."Batch No" := BatchNo;
    //             RecPHY.MODIFY;
    //         END;

    //         RecVT.RESET;
    //         RecVT.SETCURRENTKEY("Bute No.", "Sample Code", "Temp Season Code", "Item No.", "Crop Code", "Source Type");
    //         RecVT.SETRANGE("Bute No.", ButteNo);
    //         RecVT.SETRANGE("Temp Season Code", Season);
    //         RecVT.SETRANGE("Item No.", ItemNo);
    //         RecVT.SETRANGE("Crop Code", CropCode);
    //         RecVT.SETRANGE("Source Type", SourceType);
    //         RecVT.SETRANGE(Invalid, FALSE);
    //         IF RecVT.FINDFIRST THEN BEGIN
    //             RecVT."Date of Dividng" := DateOfDividing;
    //             RecVT."Batch No" := BatchNo;
    //             RecVT.MODIFY;
    //         END;
    //     END;

    // end;

    // // [Scope('Internal')]
    // procedure CheckBatchPermission(var Rec81: Record "Gen. Journal Line")
    // var
    //     Rec232: Record "Gen. Journal Batch";
    //     RecUL: Record "User Location";
    // begin
    //     //IF USERID<>'SAMBHAJI TANDALE' THEN
    //     //Rec81.TESTFIELD("Document Type");
    //     // IF (Rec81."Document Type" = Rec81."Document Type"::" ") AND (Rec81."Journal Template Name" = 'JOURNAL') THEN
    //     //     Rec81.TESTFIELD(Comment, 'Transfer');
    //     //IF NOT (Rec81."Journal Template Name" IN ['JOURNAL', 'GENERAL', 'PAYROLL']) THEN
    //     //Rec81.TESTFIELD("Document Type");     //mk for opening pass

    //     IF Rec81."Journal Template Name" IN ['CASHPAYME', 'CASHRCPT', 'CASHRECPT'] THEN BEGIN
    //         Rec232.RESET;
    //         Rec232.GET(Rec81."Journal Template Name", Rec81."Journal Batch Name");
    //         RecUL.RESET;
    //         RecUL.SETRANGE("User ID", USERID);
    //         RecUL.SETRANGE("Location Code", Rec232."Location Code");
    //         IF RecUL.FINDFIRST THEN BEGIN
    //             IF (NOT RecUL."Cash Payment") AND (Rec81."Journal Template Name" = 'CASHPAYME') THEN
    //                 ERROR('You Do Not Have Permission for Cash Payment');
    //             IF (NOT RecUL."Cash Receipt") AND (Rec81."Journal Template Name" IN ['CASHRCPT', 'CASHRECPT']) THEN
    //                 ERROR('You Do Not Have Permission for Cash Receipt');
    //         END ELSE
    //             ERROR('You Do Not Have Permission for Batch Contact Admin');
    //     END;
    //     IF Rec81."Journal Template Name" IN ['PAYROLL'] THEN
    //         IF (Rec81."Account No." IN ['11040220', '11040103']) OR (Rec81."Bal. Account No." IN ['11040220', '11040103']) THEN BEGIN
    //             Rec81.TESTFIELD("Emp ID");
    //             Rec81.TESTFIELD(Employee);
    //             IF Rec81."Account No." = '11040220' THEN
    //                 Rec81.TESTFIELD("Pay Element");
    //         END
    // end;

    // // [Scope('Internal')]
    // procedure CheckYearandState(ItemNo: Code[20]; LocationCode: Code[20]; VarientCode: Code[20]; ButteNo: Code[20]; Season: Code[20]; YearandState: Code[20]) DuplicateExist: Boolean
    // var
    //     RecILE: Record "Item Ledger Entry";
    // begin
    //     IF (ItemNo = '') OR (LocationCode = '') OR (VarientCode = '') OR (ButteNo = '') OR (Season = '') OR (YearandState = '') THEN
    //         ERROR('Unable to fetch details of Year & State');
    //     RecILE.RESET;
    //     RecILE.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Season Code", "Year and State", "Location Code", "Remaining Quantity");
    //     RecILE.SETRANGE("Item No.", ItemNo);
    //     RecILE.SETRANGE("Variant Code", VarientCode);
    //     RecILE.SETRANGE("Lot No.", ButteNo);
    //     RecILE.SETRANGE("Season Code", Season);
    //     RecILE.SETFILTER("Year and State", '<>%1', YearandState);
    //     RecILE.SETRANGE("Location Code", LocationCode);
    //     RecILE.SETFILTER("Remaining Quantity", '>0');
    //     IF RecILE.FINDFIRST THEN BEGIN
    //         MESSAGE('You can not Select Butte No Because there are Multiple Year & State Exist Kindly Select Reservation Manually');
    //         EXIT(TRUE);
    //     END ELSE
    //         EXIT(FALSE);
    // end;

    // // [Scope('Internal')]
    // procedure CreateQCSampleRVDOpening(var Trec50007: Record "Process Header")
    // var
    //     rec27: Record Item;
    //     recCSM: Record "Crop Stage Master";
    //     Trec50008: Record "Process Line";
    //     SampleCodeAllotment: Record "QC Sample Code Allotment";
    //     QCResultDeclaration: Record "QC Result Declaration";
    //     recPurchAndPayableSetup: Record "Purchases & Payables Setup";
    //     RVDQCSampleCode: Record "RVD QC Sample Code";
    //     ProcessInvoiceLine: Record "Process Invoice Line";
    //     "----------------creating sample if already not exists-----------------": Integer;
    //     GotTestingMaster: Record "Got Testing Master";
    //     BTElisaTestingMaster: Record "BT/Elisa Testing Master";
    //     GerminationEvaluation: Record "Germination Evaluation";
    //     PhysicalPurityDetermination: Record "Physical Purity Determination";
    //     MoistureDetermination: Record "Moisture Determination";
    //     VigourTest: Record "Vigour Test";
    //     TempCropStageMaster: Record "Crop Stage Master";
    //     "count": Integer;
    //     RecILE: Record "Item Ledger Entry";
    // begin
    //     Trec50007.TESTFIELD("RVD Opening", TRUE);
    //     Trec50008.RESET;
    //     Trec50008.SETCURRENTKEY("Document No.");
    //     Trec50008.SETRANGE("Document No.", Trec50007."No.");
    //     IF Trec50008.FINDSET THEN BEGIN
    //         REPEAT
    //             IF rec27.GET(Trec50007."Item No.") THEN BEGIN
    //                 IF rec27."Skip QC for this Item" = FALSE THEN BEGIN
    //                     IF (rec27."Class of Seeds" = rec27."Class of Seeds"::Foundation) OR (rec27."Class of Seeds" = rec27."Class of Seeds"::TL) THEN BEGIN
    //                         ProcessInvoiceLine.RESET;
    //                         ProcessInvoiceLine.SETCURRENTKEY("Item No.", "From Bute No.", "From Stage", RVD);
    //                         ProcessInvoiceLine.SETRANGE("Item No.", Trec50008."Item No.");
    //                         ProcessInvoiceLine.SETRANGE("From Bute No.", Trec50008."From Bute No.");
    //                         ProcessInvoiceLine.SETRANGE("From Stage", 'CLEANING');
    //                         ProcessInvoiceLine.SETRANGE(Regrading, FALSE);
    //                         ProcessInvoiceLine.SETRANGE(RVD, FALSE);
    //                         ProcessInvoiceLine.SETRANGE("Season Code", Trec50007.Season);
    //                         IF ProcessInvoiceLine.FINDFIRST THEN
    //                             ERROR('You Can Not Select Old System RVD Boolean True for Butte No %1', Trec50008."From Bute No.");

    //                         CLEAR(SampleCodeAllotment);
    //                         CLEAR(RVDQCSampleCode);
    //                         RVDQCSampleCode.RESET;
    //                         RVDQCSampleCode.SETCURRENTKEY("Bute No.", "Bute No. Year", "Serial No.", Used);
    //                         RVDQCSampleCode.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //                         RVDQCSampleCode.SETRANGE("Bute No. Year", Trec50007.Season);
    //                         RVDQCSampleCode.SETASCENDING("Serial No.", TRUE);
    //                         RVDQCSampleCode.SETRANGE(Used, TRUE);
    //                         RVDQCSampleCode.FINDLAST;
    //                         RVDQCSampleCode.TESTFIELD(Used, TRUE);
    //                         RVDQCSampleCode.TESTFIELD("QC Sample Code");
    //                         // Trec50008.TESTFIELD("New QC Sample Code",RVDQCSampleCode."QC Sample Code");
    //                         SampleCode := RVDQCSampleCode."QC Sample Code";
    //                         //Check Sample Code/Marketing Lot for QC exists or not
    //                         SampleCodeAllotment.RESET;
    //                         SampleCodeAllotment.SETCURRENTKEY("Bute No.", "Bute No. Year", "Marketing Lot", Invalid);
    //                         SampleCodeAllotment.SETRANGE("Bute No.", Trec50008."From Bute No.");
    //                         SampleCodeAllotment.SETRANGE("Bute No. Year", Trec50007.Season);
    //                         SampleCodeAllotment.SETRANGE("Marketing Lot", TRUE);
    //                         SampleCodeAllotment.SETRANGE(Invalid, FALSE);
    //                         IF NOT SampleCodeAllotment.FINDFIRST THEN BEGIN
    //                             CLEAR(SampleCodeAllotment);
    //                             SampleCodeAllotment.RESET;
    //                             SampleCodeAllotment.INIT;
    //                             SampleCodeAllotment.VALIDATE("Bute No.", Trec50008."From Bute No.");
    //                             SampleCodeAllotment.VALIDATE("Sample Code", RVDQCSampleCode."QC Sample Code");
    //                             SampleCodeAllotment.VALIDATE("Bute No. Year", Trec50007.Season);
    //                             SampleCodeAllotment.VALIDATE("Sample Code Year", RVDQCSampleCode."QC Sample Code");
    //                             SampleCodeAllotment.VALIDATE(Invalid, FALSE);
    //                             SampleCodeAllotment.VALIDATE("Marketing Lot", TRUE);
    //                             SampleCodeAllotment.INSERT(TRUE);
    //                         END;
    //                         IF SampleCode = '' THEN
    //                             ERROR('Sample Code Can Not Be Found');
    //                         //Create Samples
    //                         recCSM.RESET;
    //                         recCSM.SETCURRENTKEY("Crop Code", Stage, Type);
    //                         recCSM.SETRANGE("Crop Code", Trec50007."Crop Code");
    //                         recCSM.SETRANGE(Stage, Trec50007."To Stage");
    //                         recCSM.SETRANGE(Type, recCSM.Type::"Process Transfer");
    //                         IF recCSM.FINDFIRST THEN BEGIN
    //                             IF (Trec50007.Regrading = FALSE) AND (Trec50007.RVD = FALSE) THEN BEGIN
    //                                 IF (recCSM.GOT = TRUE) THEN
    //                                     CreateGot(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM.BT = TRUE) THEN
    //                                     CreateBT(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Germination Determination" = TRUE) THEN
    //                                     CreateGD(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Physical Purity Determination" = TRUE) THEN
    //                                     CreatePPD(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Moisture Determination" = TRUE) THEN
    //                                     CreateMD(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                                 IF (recCSM."Vigour Test" = TRUE) THEN
    //                                     CreateVT(Trec50007, Trec50008, rec27."Class of Seeds", recCSM."Allow Duplicate");
    //                             END ELSE BEGIN
    //                                 IF (recCSM."Re-grading With Only GD" = TRUE) AND (recCSM."Re-grading With All STL Tests" = TRUE) THEN
    //                                     ERROR('You cannot tick "Re-grading With Only GD" & "Re-grading With All STL Tests" simultanously at same time.');
    //                                 IF (recCSM."Re-grading With Only GD" = TRUE) AND (recCSM."Re-grading With All STL Tests" = FALSE) THEN
    //                                     CreateGDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                 IF (recCSM."Re-grading With Only GD" = FALSE) AND (recCSM."Re-grading With All STL Tests" = TRUE) THEN BEGIN
    //                                     IF recCSM."Germination Determination" = TRUE THEN
    //                                         CreateGDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Physical Purity Determination" = TRUE THEN
    //                                         CreatePPDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Moisture Determination" = TRUE THEN
    //                                         CreateMDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     //                IF recCSM."Vigour Test" = TRUE THEN //in regarding VT should be generated auto
    //                                     CreateVTForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                 END;
    //                                 IF (recCSM."Re-grading With Only GD" = FALSE) AND (recCSM."Re-grading With All STL Tests" = FALSE) THEN BEGIN
    //                                     IF recCSM."Germination Determination" = TRUE THEN
    //                                         CreateGDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Physical Purity Determination" = TRUE THEN
    //                                         CreatePPDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     IF recCSM."Moisture Determination" = TRUE THEN
    //                                         CreateMDForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                     //                IF recCSM."Vigour Test" = TRUE THEN //in regarding VT should be generated auto
    //                                     CreateVTForRevalidation(Trec50007, Trec50008, rec27."Class of Seeds");
    //                                 END;
    //                             END;
    //                         END;

    //                         //Create QC Result Sample
    //                         QCResultDeclaration.RESET;
    //                         QCResultDeclaration.SETCURRENTKEY("Lab Code", "Temp Bute No.", "Temp Season Code", Invalid);
    //                         QCResultDeclaration.SETRANGE("Lab Code", SampleCode);
    //                         QCResultDeclaration.SETRANGE("Temp Bute No.", Trec50008."From Bute No.");
    //                         QCResultDeclaration.SETRANGE("Temp Season Code", Trec50007.Season);
    //                         QCResultDeclaration.SETRANGE(Invalid, FALSE);
    //                         IF NOT QCResultDeclaration.FINDFIRST THEN BEGIN
    //                             QCResultDeclaration.RESET;
    //                             QCResultDeclaration.INIT;
    //                             recUL.RESET;
    //                             recUL.SETCURRENTKEY("User ID");
    //                             recUL.SETRANGE("User ID", USERID);
    //                             recUL.SETRANGE("QC Result Declaration", TRUE);
    //                             IF recUL.FINDFIRST THEN BEGIN
    //                                 IF recPurchAndPayableSetup.GET THEN BEGIN
    //                                     recPurchAndPayableSetup.TESTFIELD("QC Result Declara. No.");
    //                                     QCResultDeclaration."No." := NoSeriesMgt.GetNextNo(recPurchAndPayableSetup."QC Result Declara. No.", Trec50007.Date, TRUE);//This PBS kanhaiya
    //                                 END ELSE
    //                                     ERROR('Purchase & Payable Setup %1 ''. It cannot be Blank.', recPurchAndPayableSetup.FIELDCAPTION("QC Result Declara. No."));
    //                             END ELSE
    //                                 ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
    //                             QCResultDeclaration.VALIDATE("Lab Code", SampleCode);
    //                             QCResultDeclaration.VALIDATE("Temp Season Code", Trec50007.Season);
    //                             QCResultDeclaration.VALIDATE("Temp Document No.", documentno);
    //                             QCResultDeclaration.VALIDATE("Temp Variant Code", Trec50007."To Stage");
    //                             QCResultDeclaration.VALIDATE("Temp Bute No.", Trec50008."From Bute No.");
    //                             QCResultDeclaration.VALIDATE("Process Transfer Entry", TRUE);
    //                             QCResultDeclaration."Prefix No." := Trec50008."Prefix No.";
    //                             QCResultDeclaration.INSERT(TRUE);
    //                         END;
    //                     END;
    //                 END;
    //             END;
    //         UNTIL Trec50008.NEXT = 0;
    //     END;
    // end;

    // // [Scope('Internal')]
    // procedure ConvertStringToDate(ConversionString: Text; Condition: Option " ",DDMMYYYY,MMDDYYYY,YYYYMMDD) TempDate: Date
    // var
    //     Day: Integer;
    //     Month: Integer;
    //     Year: Integer;
    //     TempString: Text;
    // begin
    //     IF ConversionString = '' THEN BEGIN
    //         CLEAR(TempDate);
    //         EXIT(TempDate);
    //     END;
    //     IF Condition = Condition::DDMMYYYY THEN BEGIN
    //         EVALUATE(Day, DELSTR(ConversionString, STRPOS(ConversionString, '-')));
    //         EVALUATE(Month, DELSTR(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), STRPOS(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), '-')));
    //         EVALUATE(Year, COPYSTR(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), STRPOS(ConversionString, '-') + 1));
    //         TempDate := DMY2DATE(Day, Month, Year);
    //     END;
    //     IF Condition = Condition::MMDDYYYY THEN BEGIN
    //         IF STRPOS(ConversionString, ' ') <> 0 THEN BEGIN
    //             // TempString := DELSTR(ConversionString,STRPOS(ConversionString,' '));
    //             // EVALUATE(TempDate,TempString);
    //             EVALUATE(Day, DELSTR(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), STRPOS(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), '-')));
    //             EVALUATE(Month, DELSTR(ConversionString, STRPOS(ConversionString, '-')));
    //             EVALUATE(Year, DELSTR(COPYSTR(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), STRPOS(ConversionString, '-') + 1), STRPOS(COPYSTR(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), STRPOS(ConversionString, '-') + 2), ' ') + 2));
    //             TempDate := DMY2DATE(Day, Month, Year);
    //             // MESSAGE('day %1 month %2 year %3 date %4',Day,Month,Year,TempDate);
    //         END ELSE BEGIN
    //             // EVALUATE(TempDate,ConversionString);
    //             EVALUATE(Day, DELSTR(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), STRPOS(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), '-')));
    //             EVALUATE(Month, DELSTR(ConversionString, STRPOS(ConversionString, '-')));
    //             EVALUATE(Year, COPYSTR(COPYSTR(ConversionString, STRPOS(ConversionString, '-') + 1), STRPOS(ConversionString, '-') + 1));
    //             TempDate := DMY2DATE(Day, Month, Year);
    //         END;
    //     END;
    //     IF Condition = Condition::YYYYMMDD THEN BEGIN
    //         EVALUATE(Day, COPYSTR(ConversionString, 9, 2));
    //         EVALUATE(Month, COPYSTR(ConversionString, 6, 2));
    //         EVALUATE(Year, COPYSTR(ConversionString, 1, 4));
    //         TempDate := DMY2DATE(Day, Month, Year);
    //         MESSAGE('day %1 month %2 year %3 date %4', Day, Month, Year, TempDate);
    //     END;
    // end;

    // local procedure "------------------------manoj-----------------------"()
    // begin
    // end;

    // //[Scope('Internal')]
    // procedure ModifyDate_PP_MOIST(ButeNo: Code[20]; SampleCode: Code[20]; Season: Code[20]; ItemNo: Code[20]; CropCode: Code[20]; SourceType: Option " ",Foundation,Hybrid; DateOfPutting: Date)
    // var
    //     RecSTLGer: Record "Germination Evaluation";
    //     RecMOI: Record "Moisture Determination";
    //     RecPHY: Record "Physical Purity Determination";
    // begin

    //     RecMOI.RESET;
    //     RecMOI.SETCURRENTKEY("Bute No.", "Sample Code", "Temp Season Code", "Item No.", "Crop Code", "Source Type");
    //     RecMOI.SETRANGE("Bute No.", ButeNo);
    //     RecMOI.SETRANGE("Temp Season Code", Season);
    //     RecMOI.SETRANGE("Item No.", ItemNo);
    //     RecMOI.SETRANGE("Crop Code", CropCode);
    //     RecMOI.SETRANGE("Source Type", SourceType);
    //     RecMOI.SETRANGE(Invalid, FALSE);
    //     RecMOI.SETFILTER("Subjected to Test Dt", '%1', 0D);//11-01-22
    //     IF RecMOI.FINDFIRST THEN BEGIN
    //         RecMOI."Subjected to Test Dt" := DateOfPutting;
    //         RecMOI.MODIFY;
    //     END;

    //     RecPHY.RESET;
    //     RecPHY.SETCURRENTKEY("Bute No.", "Sample Code", "Temp Season Code", "Item No.", "Crop Code", "Source Type");
    //     RecPHY.SETRANGE("Bute No.", ButeNo);
    //     RecPHY.SETRANGE("Temp Season Code", Season);
    //     RecPHY.SETRANGE("Item No.", ItemNo);
    //     RecPHY.SETRANGE("Crop Code", CropCode);
    //     RecPHY.SETRANGE("Source Type", SourceType);
    //     RecPHY.SETRANGE(Invalid, FALSE);
    //     RecPHY.SETFILTER("Subjected to Test Dt", '%1', 0D);//11-01-22
    //     IF RecPHY.FINDFIRST THEN BEGIN
    //         RecPHY."Subjected to Test Dt" := DateOfPutting;
    //         RecPHY.MODIFY;
    //     END;

    // end;

    local procedure "*****************-LK****************"()
    begin
    end;

    local procedure "-----------------Remaining Bottles---------"()
    begin
    end;

    // [Scope('Internal')]
    // procedure RemainingBottles(Var_ItemNo: Code[20]; Var_LocationCode: Code[20]; Var_VariantCode: Code[20]; Var_ButeNo: Code[20]; VarSubLot: Code[20]): Decimal
    // var
    //     ItemLedgerEntryPositive: Record "Item Ledger Entry";
    //     ItemLedgerEntryNegative: Record "Item Ledger Entry";
    //     PositiveBags: Decimal;
    //     NegativeBags: Decimal;
    //     PositiveQty: Decimal;
    //     NegativeQty: Decimal;
    // begin
    //     IF (Var_ItemNo = '') OR (Var_LocationCode = '') OR (Var_VariantCode = '') OR (Var_ButeNo = '') THEN
    //         ERROR('Unable to fetch details of Remaining No. of Bags');
    //     CLEAR(PositiveBags);
    //     CLEAR(NegativeBags);
    //     ItemLedgerEntryPositive.RESET;
    //     ItemLedgerEntryPositive.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Entry Type", "Location Code", "Sub Lot No");
    //     ItemLedgerEntryPositive.SETRANGE("Item No.", Var_ItemNo);
    //     ItemLedgerEntryPositive.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryPositive."Entry Type"::"Positive Adjmt.", ItemLedgerEntryPositive."Entry Type"::Purchase, ItemLedgerEntryPositive."Entry Type"::Transfer,
    //                                                               ItemLedgerEntryPositive."Entry Type"::Sale);
    //     ItemLedgerEntryPositive.SETRANGE("Location Code", Var_LocationCode);
    //     ItemLedgerEntryPositive.SETRANGE("Variant Code", Var_VariantCode);
    //     ItemLedgerEntryPositive.SETRANGE("Lot No.", Var_ButeNo);
    //     ItemLedgerEntryPositive.SETRANGE("Sub Lot No", VarSubLot);
    //     IF ItemLedgerEntryPositive.FINDSET THEN BEGIN
    //         REPEAT
    //             IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::" " THEN BEGIN
    //                 PositiveBags += ItemLedgerEntryPositive."No. of Bottles";
    //                 PositiveQty += ItemLedgerEntryPositive.Quantity;
    //             END;
    //             IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Purchase Receipt" THEN BEGIN
    //                 PositiveBags += ItemLedgerEntryPositive."No. of Bottles";
    //                 PositiveQty += ItemLedgerEntryPositive.Quantity;
    //             END;
    //             IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Sales Return Receipt" THEN BEGIN
    //                 PositiveBags += ItemLedgerEntryPositive."No. of Bottles";
    //                 PositiveQty += ItemLedgerEntryPositive.Quantity;
    //             END;
    //             IF ItemLedgerEntryPositive."Document Type" = ItemLedgerEntryPositive."Document Type"::"Transfer Receipt" THEN BEGIN
    //                 PositiveBags += ItemLedgerEntryPositive."No. of Bottles";
    //                 PositiveQty += ItemLedgerEntryPositive.Quantity;
    //             END;
    //         UNTIL ItemLedgerEntryPositive.NEXT = 0;
    //     END;
    //     ItemLedgerEntryNegative.RESET;
    //     ItemLedgerEntryNegative.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Entry Type", "Location Code", "Sub Lot No");
    //     ItemLedgerEntryNegative.SETRANGE("Item No.", Var_ItemNo);
    //     ItemLedgerEntryNegative.SETFILTER("Entry Type", '%1|%2|%3|%4', ItemLedgerEntryNegative."Entry Type"::"Negative Adjmt.", ItemLedgerEntryNegative."Entry Type"::Sale, ItemLedgerEntryNegative."Entry Type"::Transfer,
    //                                                               ItemLedgerEntryPositive."Entry Type"::Purchase);
    //     ItemLedgerEntryNegative.SETRANGE("Location Code", Var_LocationCode);
    //     ItemLedgerEntryNegative.SETRANGE("Variant Code", Var_VariantCode);
    //     ItemLedgerEntryNegative.SETRANGE("Lot No.", Var_ButeNo);
    //     ItemLedgerEntryNegative.SETRANGE("Sub Lot No", VarSubLot);
    //     IF ItemLedgerEntryNegative.FINDSET THEN BEGIN
    //         REPEAT
    //             IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::" " THEN BEGIN
    //                 NegativeBags += ItemLedgerEntryNegative."No. of Bottles";
    //                 NegativeQty += ItemLedgerEntryNegative.Quantity;
    //             END;
    //             IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Purchase Return Shipment" THEN BEGIN
    //                 NegativeBags += ItemLedgerEntryNegative."No. of Bottles";
    //                 NegativeQty += ItemLedgerEntryNegative.Quantity;
    //             END;
    //             IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Sales Shipment" THEN BEGIN
    //                 NegativeBags += ItemLedgerEntryNegative."No. of Bottles";
    //                 NegativeQty += ItemLedgerEntryNegative.Quantity;
    //             END;
    //             IF ItemLedgerEntryNegative."Document Type" = ItemLedgerEntryNegative."Document Type"::"Transfer Shipment" THEN BEGIN
    //                 NegativeBags += ItemLedgerEntryNegative."No. of Bottles";
    //                 NegativeQty += ItemLedgerEntryNegative.Quantity;
    //             END;
    //         UNTIL ItemLedgerEntryNegative.NEXT = 0;
    //     END;

    //     //MESSAGE('PositiveBags %1\NegativeBags %2\PositiveQty %3\NegativeQty %4',PositiveBags,NegativeBags,PositiveQty,NegativeQty);
    //     IF PositiveBags = NegativeBags THEN
    //         IF PositiveQty = ABS(NegativeQty) THEN
    //             EXIT(0)
    //         ELSE
    //             EXIT(PositiveBags);

    //     EXIT(PositiveBags - NegativeBags);
    // end;

    //[Scope('Internal')]
    // procedure CheckRIB_Blend(RIB_OR_Blend: Text; ItemNo_: Text; ButeNo_: Text; Season_: Text) Text: Text
    // var
    //     RIBLine: Record "RIB Line";
    //     BlendLine: Record "Blend Line";
    //     ItemLedgerEntry: Record "Item Ledger Entry";
    // begin
    //     //Checking Source of RIB/Blend Lot like what it is before RIB/Blend RVD,Regrading or Fresh
    //     ItemLedgerEntry.RESET;
    //     ItemLedgerEntry.SETCURRENTKEY("Entry No.", "Item No.", "Lot No.", "Season Code");
    //     ItemLedgerEntry.SETRANGE("Lot No.", ButeNo_);
    //     ItemLedgerEntry.SETRANGE("Season Code", Season_);
    //     ItemLedgerEntry.SETRANGE("Item No.", ItemNo_);
    //     ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
    //     ItemLedgerEntry.SETRANGE(RIB, FALSE);
    //     ItemLedgerEntry.SETRANGE(Blended, FALSE);
    //     ItemLedgerEntry.SETRANGE("Variant Code", 'CLEANING');
    //     ItemLedgerEntry.SETASCENDING("Entry No.", TRUE);
    //     IF ItemLedgerEntry.FINDLAST THEN BEGIN
    //         IF ItemLedgerEntry.RVD THEN
    //             EXIT('RVD')
    //         ELSE
    //             IF ItemLedgerEntry.Regrading THEN
    //                 EXIT('REGRADING')
    //             ELSE
    //                 EXIT('FRESH');
    //     END ELSE
    //         EXIT('FRESH');
    // end;

    // [Scope('Internal')]
    // procedure CalculateItemNetChange(ItemNo: Code[20]; LocationCode: Code[20]; DateFilter: Text; VarientCode: Code[20]; LotNo: Code[20]; CropType: Text; ClassofSeed: Text; ItemName: Text; CropCode: Code[20]; LocationGrpCode: Code[20]; PrefixNo: Code[20]; Season: Code[20]) NetChange: Decimal
    // var
    //     Item: Record Item;
    // begin
    //     //This PBS kanhaiya
    //     Item.RESET;
    //     Item.SETCURRENTKEY("No.");
    //     IF ItemNo <> '' THEN
    //         Item.SETRANGE("No.", ItemNo);
    //     Item.FINDFIRST;
    //     IF LocationCode <> '' THEN
    //         Item.SETFILTER("Location Filter", LocationCode);
    //     IF LocationGrpCode <> '' THEN
    //         Item.SETFILTER(LocationGroupFilter, LocationGrpCode);
    //     IF CropType <> '' THEN
    //         Item.SETFILTER(CropTypeFilter, CropType);
    //     IF ClassofSeed <> '' THEN
    //         Item.SETFILTER(ClassofSeedFilter, ClassofSeed);
    //     IF CropCode <> '' THEN
    //         Item.SETFILTER(CropCodeFilter, CropCode);
    //     IF DateFilter <> '' THEN
    //         Item.SETFILTER("Date Filter", DateFilter);
    //     IF VarientCode <> '' THEN
    //         Item.SETFILTER("Variant Filter", VarientCode);
    //     IF LotNo <> '' THEN
    //         Item.SETFILTER("Lot No. Filter", LotNo);
    //     IF ItemName <> '' THEN
    //         Item.SETFILTER(ItemNameFilter, ItemName);
    //     IF PrefixNo <> '' THEN
    //         Item.SETFILTER(PrefixNoFilter, PrefixNo);
    //     IF Season <> '' THEN
    //         Item.SETFILTER("Season Filter", Season);
    //     Item.CALCFIELDS("Custom Net Change");
    //     EXIT(Item."Custom Net Change");
    // end;


}

