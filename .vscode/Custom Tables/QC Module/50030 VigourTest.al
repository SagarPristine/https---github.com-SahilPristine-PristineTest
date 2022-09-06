table 50030 "Vigour Test"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                recul: Record "User Location";
                recloc: record Location;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE("Vigour Test", TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("VT Series");
                            // NoSeriesMgt.TestManual(recLoc."VT Series");
                            // "No. Series" := '';
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("VT Series"));
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
        field(7; "Subjected to Test Dt"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sowing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Vigour %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Vigour Test Result"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;

            trigger OnValidate()
            begin
                Rec."Vigour Test Result Date" := TODAY;
                Rec."Result User Id" := USERID;
            end;
        }
        field(11; "Vigour Test Result Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; Invalid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Invalid User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Sample Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Result User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Foundation Process,Hybrid Process,Organizer Process';
            OptionMembers = " ","Foundation Process","Hybrid Process","Organizer Process";
        }
        field(18; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Item Ledger Entry"."Posting Date" WHERE("Document No." = FIELD("Document No."),
                                                                           "Item No." = FIELD("Item No."),
                                                                           "Crop Code" = FIELD("Crop Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Bute No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Item Product Group Code"; Code[100])
        {
            CalcFormula = Lookup(Item."Crop Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Item Class of Seeds"; Option)
        {
            CalcFormula = Lookup(Item."Class of Seeds" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Class of Seeds';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(24; "Final Result Posting Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Received Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
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
            recUL.SETRANGE("Vigour Test", TRUE);
            IF recUL.FINDFIRST THEN BEGIN
                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                    recLoc.TESTFIELD("VT Series");
                    NoSeriesMgt.InitSeries(recLoc."VT Series", xRec."No. Series", 0D, "No.", "No. Series");
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("VT Series"));
            END ELSE
                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
        END;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        recUL: Record 50015;
        recLoc: Record 14;
}

