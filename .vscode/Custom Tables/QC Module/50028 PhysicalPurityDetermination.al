table 50028 "Physical Purity Determination"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                recul: record "User Location";
                recloc: Record Location;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE("Physical Purity Determination", TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("PPD Series");
                            // NoSeriesMgt.TestManual(recLoc."PPD Series");
                            // "No. Series" := '';
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("PPD Series"));
                    END ELSE
                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                END;
            end;
        }
        field(2; "Crop Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Crop Master".Code;
        }
        field(3; "Item No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Qty (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Stage; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Sample Receiving Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Subjected to Test Dt"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Date of Test"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Normal Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Disabled';
            Enabled = false;
        }
        field(11; "Abnormal Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Disabled';
            Enabled = false;
        }
        field(12; "Hard Seed Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Disabled';
            Enabled = false;
        }
        field(13; "Dead Seed Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Disabled';
            Enabled = false;
        }
        field(14; "Fresh Ungerminated Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Disabled';
            Enabled = false;
        }
        field(15; Results; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(16; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(19; "Pure Seed (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Pure Seed (%)" <> 0 THEN BEGIN

                //Codeunit50000.CalculateResult(Rec."Item No.", 6, Rec."Pure Seed (%)", PSPrcntge, MaxPSPrcntge);
                IF (PSPrcntge = TRUE) AND (MaxPSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Pure Seed (%)", Rec."Result Pure Seed (%)"::Pass)
                ELSE
                    Rec.VALIDATE("Result Pure Seed (%)", Rec."Result Pure Seed (%)"::Fail);
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(20; "Result Pure Seed (%)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(21; "Inert Matter (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Inert Matter (%)" <> 0 THEN BEGIN
                IMPrcntge := FALSE;
                MaxIMPrcntge := FALSE;
                //Codeunit50000.CalculateResult(Rec."Item No.", 7, Rec."Inert Matter (%)", IMPrcntge, MaxIMPrcntge);
                IF (IMPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Inert Matter (%)", Rec."Result Inert Matter (%)"::Pass)
                ELSE
                    Rec.VALIDATE("Result Inert Matter (%)", Rec."Result Inert Matter (%)"::Fail);
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(22; "Result Inert Matter (%)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(23; "Cut Seed (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /* //PBS-SAG NOT Required
                CheckPassOrFail;
                //IF Rec."Cut Seed (%)" <> 0 THEN BEGIN
                  Codeunit50000.CalculateResult(Rec."Item No.",9,Rec."Cut Seed (%)",CSPrcntge,MaxCSPrcntge);
                  IF (CSPrcntge = TRUE) AND (MaxCSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Cut Seed (%)",Rec."Result Cut Seed (%)"::Pass)
                  ELSE
                    Rec.VALIDATE("Result Cut Seed (%)",Rec."Result Cut Seed (%)"::Fail);
                  IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (CSPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODSPrcntge = TRUE) AND
                     (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (MaxCSPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODSPrcntge = TRUE)  THEN
                    Rec.VALIDATE("Physical Purity Result",Rec."Physical Purity Result"::Pass)
                  ELSE
                    Rec.VALIDATE("Physical Purity Result",Rec."Physical Purity Result"::Fail);
                //END;
                */ //PBS-SAG NOT Required

            end;
        }
        field(24; "Result Cut Seed (%)"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(25; "Other Crop Seed"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Other Crop Seed" <> 0 THEN BEGIN
                //Codeunit50000.CalculateResult(Rec."Item No.", 8, Rec."Other Crop Seed", OCSPrcntge, maxOCSPrcntge);
                IF (OCSPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Other Crop Seed", Rec."Result Other Crop Seed"::Pass)
                ELSE
                    Rec.VALIDATE("Result Other Crop Seed", Rec."Result Other Crop Seed"::Fail);
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(26; "UOM Other Crop Seed"; Code[10])
        {
            DataClassification = ToBeClassified;
            InitValue = 'NOS';
            TableRelation = "Unit of Measure".Code;
        }
        field(27; "Result Other Crop Seed"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(28; "Objectionable Weed Seed"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Objectionable Weed Seed" <> 0 THEN BEGIN
                //Codeunit50000.CalculateResult(Rec."Item No.", 9, Rec."Objectionable Weed Seed", OWSPrcntge, MaxOWSPrcntge);
                IF (OWSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Objectionable Weed Seed", Rec."Result Objectionable Weed Seed"::Pass)
                ELSE
                    Rec.VALIDATE("Result Objectionable Weed Seed", Rec."Result Objectionable Weed Seed"::Fail);
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(29; "UOM Objectionable Weed Seed"; Code[10])
        {
            DataClassification = ToBeClassified;
            InitValue = 'NOS';
            TableRelation = "Unit of Measure".Code;
        }
        field(30; "Result Objectionable Weed Seed"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(31; "Insect Damage (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Insect Damage (%)" <> 0 THEN BEGIN
                //Codeunit50000.CalculateResult(Rec."Item No.", 11, Rec."Insect Damage (%)", IDPrcntge, MaxIDPrcntge);
                IF (IDPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Insect Damage (%)", Rec."Result Insect Damage (%)"::Pass)
                ELSE
                    Rec.VALIDATE("Result Insect Damage (%)", Rec."Result Insect Damage (%)"::Fail);
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(32; "Result Insect Damage (%)"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(33; "Other Distinguish Variety"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Other Distinguish Seed" <> 0 THEN BEGIN
                //Codeunit50000.CalculateResult(Rec."Item No.", 12, Rec."Other Distinguish Variety", ODVPrcntge, MaxODVPrcntge);
                IF (ODVPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) THEN
                    Rec."Result Other Distinguish Varie" := Rec."Result Other Distinguish Varie"::Pass
                ELSE
                    Rec."Result Other Distinguish Varie" := Rec."Result Other Distinguish Varie"::Fail;
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(34; "UOM Other Distinguish Variety"; Code[10])
        {
            DataClassification = ToBeClassified;
            InitValue = 'NOS';
            TableRelation = "Unit of Measure".Code;
        }
        field(35; "Result Other Distinguish Varie"; Option)
        {
            Caption = 'Result Other Distinguish Variety';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(36; "Physical Purity Result"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;

            trigger OnValidate()
            begin
                Rec."Physical Purity Result Date" := TODAY;
                //Rec."Date of Test" := TODAY;
                Rec."Result User Id" := USERID;
                Rec.Results := Rec."Physical Purity Result";
            end;
        }
        field(37; "Physical Purity Result Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; Invalid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Invalid User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Sample Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Result User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Foundation Process,Hybrid Process,Organizer Process';
            OptionMembers = " ","Foundation Process","Hybrid Process","Organizer Process";
        }
        field(43; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Item Ledger Entry"."Posting Date" WHERE("Document No." = FIELD("Document No."),
                                                                           "Item No." = FIELD("Item No."),
                                                                           "Crop Code" = FIELD("Crop Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(44; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Bute No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Item Product Group Code"; Code[100])
        {
            CalcFormula = Lookup(Item."Crop Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; OCS; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(48; WS; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(49; ODV; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Inert Matter"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Item Class of Seeds"; Option)
        {
            CalcFormula = Lookup(Item."Class of Seeds" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Class of Seeds';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(52; "Final Result Posting Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Received Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Expected Observation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Putting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Weed Seed"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Objectionable Weed Seed" <> 0 THEN BEGIN
                //  Codeunit50000.CalculateResult(Rec."Item No.", 9, Rec."Weed Seed", WSPrcntge, MaxWSPrcntge);
                IF (WSPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Weed Seed", Rec."Result Weed Seed"::Pass)
                ELSE
                    Rec.VALIDATE("Result Weed Seed", Rec."Result Weed Seed"::Fail);
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(57; "Result Weed Seed"; Option)
        {
            Caption = 'Result Other Distinguish Variety';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(58; "Huskless Seed (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPassOrFail;
                //IF Rec."Pure Seed (%)" <> 0 THEN BEGIN
                //Codeunit50000.CalculateResult(Rec."Item No.", 13, Rec."Huskless Seed (%)", HSPrcntge, MaxHSPrcntge);
                IF (PSPrcntge = TRUE) AND (MaxPSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Result Huskless Seed (%)", Rec."Result Huskless Seed (%)"::Pass)
                ELSE
                    Rec.VALIDATE("Result Huskless Seed (%)", Rec."Result Huskless Seed (%)"::Fail);
                IF (PSPrcntge = TRUE) AND (IMPrcntge = TRUE) AND (OCSPrcntge = TRUE) AND (OWSPrcntge = TRUE) AND (IDPrcntge = TRUE) AND (ODVPrcntge = TRUE) AND (WSPrcntge = TRUE) AND (HSPrcntge = TRUE) AND
                   (MaxPSPrcntge = TRUE) AND (MaxIMPrcntge = TRUE) AND (maxOCSPrcntge = TRUE) AND (MaxOWSPrcntge = TRUE) AND (MaxIDPrcntge = TRUE) AND (MaxODVPrcntge = TRUE) AND (MaxWSPrcntge = TRUE) AND (MaxHSPrcntge = TRUE) THEN
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Pass)
                ELSE
                    Rec.VALIDATE("Physical Purity Result", Rec."Physical Purity Result"::Fail);
                //END;
            end;
        }
        field(59; "Result Huskless Seed (%)"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(60; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        recul: Record "User Location";
        recloc: Record Location;
    begin
        IF "No." = '' THEN BEGIN
            recUL.RESET;
            recUL.SETCURRENTKEY("User ID");
            recUL.SETRANGE("User ID", USERID);
            recUL.SETRANGE("Physical Purity Determination", TRUE);
            IF recUL.FINDFIRST THEN BEGIN
                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                    recLoc.TESTFIELD("PPD Series");
                    NoSeriesMgt.InitSeries(recLoc."PPD Series", xRec."No. Series", 0D, "No.", "No. Series");
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("PPD Series"));
            END ELSE
                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
        END;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recUL: Record 50015;
        recLoc: Record 14;
        Codeunit50000: Codeunit 50000;
        PSPrcntge: Boolean;
        IMPrcntge: Boolean;
        CSPrcntge: Boolean;
        OCSPrcntge: Boolean;
        OWSPrcntge: Boolean;
        IDPrcntge: Boolean;
        ODVPrcntge: Boolean;
        MaxPSPrcntge: Boolean;
        MaxIMPrcntge: Boolean;
        MaxCSPrcntge: Boolean;
        maxOCSPrcntge: Boolean;
        MaxOWSPrcntge: Boolean;
        MaxIDPrcntge: Boolean;
        MaxODVPrcntge: Boolean;
        WSPrcntge: Boolean;
        MaxWSPrcntge: Boolean;
        HSPrcntge: Boolean;
        MaxHSPrcntge: Boolean;

    local procedure CheckPassOrFail()
    begin
        IF (Rec."Result Pure Seed (%)" = Rec."Result Pure Seed (%)"::Pass) OR (Stage = 'RAW') THEN
            PSPrcntge := TRUE;
        IF (Rec."Result Inert Matter (%)" = Rec."Result Inert Matter (%)"::Pass) OR (Stage = 'RAW') THEN
            IMPrcntge := TRUE;
        IF Rec."Result Other Crop Seed" = Rec."Result Other Crop Seed"::Pass THEN
            OCSPrcntge := TRUE;
        IF Rec."Result Objectionable Weed Seed" = Rec."Result Objectionable Weed Seed"::Pass THEN
            OWSPrcntge := TRUE;
        IF Rec."Result Insect Damage (%)" = Rec."Result Insect Damage (%)"::Pass THEN
            IDPrcntge := TRUE;
        IF Rec."Result Other Distinguish Varie" = Rec."Result Other Distinguish Varie"::Pass THEN
            ODVPrcntge := TRUE;
        IF Rec."Result Weed Seed" = Rec."Result Weed Seed"::Pass THEN
            WSPrcntge := TRUE;
        IF Rec."Result Huskless Seed (%)" = Rec."Result Huskless Seed (%)"::Pass THEN
            HSPrcntge := TRUE;

        IF (Rec."Result Pure Seed (%)" = Rec."Result Pure Seed (%)"::Pass) OR (Stage = 'RAW') THEN
            MaxPSPrcntge := TRUE;
        IF (Rec."Result Inert Matter (%)" = Rec."Result Inert Matter (%)"::Pass) OR (Stage = 'RAW') THEN
            MaxIMPrcntge := TRUE;
        IF Rec."Result Other Crop Seed" = Rec."Result Other Crop Seed"::Pass THEN
            maxOCSPrcntge := TRUE;
        IF Rec."Result Objectionable Weed Seed" = Rec."Result Objectionable Weed Seed"::Pass THEN
            MaxOWSPrcntge := TRUE;
        IF Rec."Result Insect Damage (%)" = Rec."Result Insect Damage (%)"::Pass THEN
            MaxIDPrcntge := TRUE;
        IF Rec."Result Other Distinguish Varie" = Rec."Result Other Distinguish Varie"::Pass THEN
            MaxODVPrcntge := TRUE;
        IF Rec."Result Weed Seed" = Rec."Result Weed Seed"::Pass THEN
            MaxWSPrcntge := TRUE;
        IF Rec."Result Huskless Seed (%)" = Rec."Result Huskless Seed (%)"::Pass THEN
            MaxHSPrcntge := TRUE;
    end;
}

