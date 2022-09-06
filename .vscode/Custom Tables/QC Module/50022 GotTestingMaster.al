table 50022 "Got Testing Master"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Recul: Record "User Location";
                recloc: Record Location;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE("Got Testing Master", TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("Got Series");
                            NoSeriesMgt.TestManual(recLoc."Got Series");
                            "No. Series" := '';
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Got Series"));
                    END ELSE
                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                END;
            end;
        }
        field(2; "Crop Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Crop Master".Code;
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(4; "Document No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Arrival Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Total No. Plants"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Total No. Geneticaly Pure Plnt", (Rec."Total No. Plants" - Rec."Total Self Plants" - Rec."Total Off Type Plants"));
            end;
        }
        field(7; "Total No. Geneticaly Pure Plnt"; Decimal)
        {
            Caption = 'Total No. of Genetically Pure Plant';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                IF Rec."Total No. Geneticaly Pure Plnt" <> 0 THEN
                    Rec.VALIDATE("Genetic Pure Plants %", ((Rec."Total No. Geneticaly Pure Plnt" * 100) / Rec."Total No. Plants"))
                ELSE
                    Rec.VALIDATE("Genetic Pure Plants %", 0);
            end;
        }
        field(8; "Total Self Plants"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Total No. Geneticaly Pure Plnt", (Rec."Total No. Plants" - Rec."Total Self Plants" - Rec."Total Off Type Plants"));
                IF Rec."Total Self Plants" <> 0 THEN
                    Rec.VALIDATE("Self Plants %", ((Rec."Total Self Plants" * 100) / Rec."Total No. Plants"))
                ELSE
                    Rec.VALIDATE("Self Plants %", 0);
            end;
        }
        field(9; "Total Off Type Plants"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Total No. Geneticaly Pure Plnt", (Rec."Total No. Plants" - Rec."Total Self Plants" - Rec."Total Off Type Plants"));
                IF Rec."Total Off Type Plants" <> 0 THEN
                    Rec.VALIDATE("Off Type Plant %", ((Rec."Total Off Type Plants" * 100) / Rec."Total No. Plants"))
                ELSE
                    Rec.VALIDATE("Off Type Plant %", 0);
            end;
        }
        field(10; "Genetic Pure Plants %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GPPPrcntge := FALSE;
                SPPrcntge := FALSE;
                OTPPrcntge := FALSE;
                MaxGPPPrcntge := FALSE;
                MaxOTPPrcntge := FALSE;
                MaxSPPrcntge := FALSE;

                // Codeunit50000.CalculateResult(Rec."Item No.", 1, Rec."Genetic Pure Plants %", GPPPrcntge, MaxGPPPrcntge);
                // Codeunit50000.CalculateResult(Rec."Item No.", 2, Rec."Self Plants %", SPPrcntge, MaxSPPrcntge);
                // Codeunit50000.CalculateResult(Rec."Item No.", 3, Rec."Off Type Plant %", OTPPrcntge, MaxOTPPrcntge);
                IF (GPPPrcntge = TRUE) AND (SPPrcntge = TRUE) AND (OTPPrcntge = TRUE) AND (MaxGPPPrcntge = TRUE) AND (MaxOTPPrcntge = TRUE) AND (MaxSPPrcntge = TRUE) THEN
                    Rec.VALIDATE(Result, Rec.Result::Pass)
                ELSE
                    Rec.VALIDATE(Result, Rec.Result::Fail);
            end;
        }
        field(11; "Self Plants %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GPPPrcntge := FALSE;
                SPPrcntge := FALSE;
                OTPPrcntge := FALSE;
                MaxGPPPrcntge := FALSE;
                MaxOTPPrcntge := FALSE;
                MaxSPPrcntge := FALSE;

                // Codeunit50000.CalculateResult(Rec."Item No.", 1, Rec."Genetic Pure Plants %", GPPPrcntge, MaxGPPPrcntge);
                // Codeunit50000.CalculateResult(Rec."Item No.", 2, Rec."Self Plants %", SPPrcntge, MaxSPPrcntge);
                // Codeunit50000.CalculateResult(Rec."Item No.", 3, Rec."Off Type Plant %", OTPPrcntge, MaxOTPPrcntge);
                IF (GPPPrcntge = TRUE) AND (SPPrcntge = TRUE) AND (OTPPrcntge = TRUE) AND (MaxGPPPrcntge = TRUE) AND (MaxOTPPrcntge = TRUE) AND (MaxSPPrcntge = TRUE) THEN
                    Rec.VALIDATE(Result, Rec.Result::Pass)
                ELSE
                    Rec.VALIDATE(Result, Rec.Result::Fail);
            end;
        }
        field(12; "Off Type Plant %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GPPPrcntge := FALSE;
                SPPrcntge := FALSE;
                OTPPrcntge := FALSE;
                MaxGPPPrcntge := FALSE;
                MaxOTPPrcntge := FALSE;
                MaxSPPrcntge := FALSE;

                // Codeunit50000.CalculateResult(Rec."Item No.", 1, Rec."Genetic Pure Plants %", GPPPrcntge, MaxGPPPrcntge);
                // Codeunit50000.CalculateResult(Rec."Item No.", 2, Rec."Self Plants %", SPPrcntge, MaxSPPrcntge);
                // Codeunit50000.CalculateResult(Rec."Item No.", 3, Rec."Off Type Plant %", OTPPrcntge, MaxOTPPrcntge);
                IF (GPPPrcntge = TRUE) AND (SPPrcntge = TRUE) AND (OTPPrcntge = TRUE) AND (MaxGPPPrcntge = TRUE) AND (MaxOTPPrcntge = TRUE) AND (MaxSPPrcntge = TRUE) THEN
                    Rec.VALIDATE(Result, Rec.Result::Pass)
                ELSE
                    Rec.VALIDATE(Result, Rec.Result::Fail);
            end;
        }
        field(13; Result; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;

            trigger OnValidate()
            begin
                Rec."Date of Result Declaration" := TODAY;
                Rec."Result User Id" := USERID;
            end;
        }
        field(14; "Date of Result Declaration"; Date)
        {
            Caption = 'Date of Result Declaration';
            DataClassification = ToBeClassified;
            Description = '//It Is Required to be filled Automatically';
            Editable = false;
        }
        field(15; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17; Invalid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Invalid User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Document Subtype"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,Labgot';
            OptionMembers = " ",Normal,Labgot;
        }
        field(20; "Sample Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Result User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(23; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Assigned No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Foundation Process,Hybrid Process,Organizer Process';
            OptionMembers = " ","Foundation Process","Hybrid Process","Organizer Process";
        }
        field(26; "Stage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Item Ledger Entry"."Posting Date" WHERE("Document No." = FIELD("Document No."),
                                                                           "Item No." = FIELD("Item No."),
                                                                           "Crop Code" = FIELD("Crop Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Bute No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Item Product Group Code"; Code[100])
        {
            CalcFormula = Lookup(Item."Crop Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Item Crop Type"; Option)
        {
            CalcFormula = Lookup(Item."Crop Type" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Hybrid,Improved,Inbred,Tissue Culture,Non Hybrid,Notified,Hybrid-Notified,Research,Research Hybrid,Certified';
            OptionMembers = " ",Hybrid,Improved,Inbred,"Tissue Culture","Non Hybrid",Notified,"Hybrid-Notified",Research,"Research Hybrid",Certified;
        }
        field(32; "Final Result Posting Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Item Class of Seeds"; Option)
        {
            CalcFormula = Lookup(Item."Class of Seeds" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Class of Seeds';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }

        field(42; "Sowing Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//for got fields test';
        }
        field(43; "Got Off Type Plant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Got Off Type Plant Master".Code;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Subtype")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sample Code")
        {
        }
    }

    trigger OnInsert()
    var
        recul: Record "User Location";
        recloc: Record location;
    begin
        IF "No." = '' THEN BEGIN
            recUL.RESET;
            recUL.SETCURRENTKEY("User ID");
            recUL.SETRANGE("User ID", USERID);
            recUL.SETRANGE("Got Testing Master", TRUE);
            IF recUL.FINDFIRST THEN BEGIN
                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                    recLoc.TESTFIELD("Got Series");
                    NoSeriesMgt.InitSeries(recLoc."Got Series", xRec."No. Series", 0D, "No.", "No. Series");
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Got Series"));
            END ELSE
                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
        END;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recUL: Record 50015;
        recLoc: Record 14;
        "--------------QC-----------": Integer;
        GPPPrcntge: Boolean;
        SPPrcntge: Boolean;
        OTPPrcntge: Boolean;
        Codeunit50000: Codeunit 50000;
        MaxGPPPrcntge: Boolean;
        MaxSPPrcntge: Boolean;
        MaxOTPPrcntge: Boolean;
}

