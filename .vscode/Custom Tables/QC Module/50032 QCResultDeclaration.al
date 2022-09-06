table 50032 "QC Result Declaration"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                recul: Record "User Location";
                recloc: Record Location;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE("QC Result Declaration", TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("QC Result Declara. No.");
                            //NoSeriesMgt.TestManual(recLoc."PPD Series");
                            "No. Series" := '';
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("QC Result Declara. No."));
                    END ELSE
                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                END;
            end;
        }
        field(2; "Lab Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF Rec."Lab Code" <> '' THEN BEGIN
                //  Rec.CALCFIELDS("Got Result");
                //  Rec.CALCFIELDS("BT/Elisa Result");
                //  Rec.CALCFIELDS("STL 1 Result");
                //  Rec.CALCFIELDS("STL 2 Result");
                //  Rec.CALCFIELDS("STL 3 Result");
                //  IF (Rec."Got Result" = Rec."Got Result"::" ") OR
                //    (Rec."BT/Elisa Result" = Rec."BT/Elisa Result"::" ") OR
                //    (Rec."STL 1 Result" = Rec."STL 1 Result"::" ") OR
                //    (Rec."STL 2 Result" = Rec."STL 2 Result"::" ") OR
                //    (Rec."STL 3 Result" = Rec."STL 3 Result"::" ") THEN BEGIN
                //    Rec.VALIDATE("Final Result",Rec."Final Result"::" ")
                //  END ELSE BEGIN
                //    IF (Rec."Got Result" = Rec."Got Result"::Pass) AND
                //      (Rec."BT/Elisa Result" = Rec."BT/Elisa Result"::Pass) AND
                //      (Rec."STL 1 Result" = Rec."STL 1 Result"::Pass) AND
                //      (Rec."STL 2 Result" = Rec."STL 2 Result"::Pass) AND
                //      (Rec."STL 3 Result" = Rec."STL 3 Result"::Pass) THEN BEGIN
                //      Rec.VALIDATE("Final Result",Rec."Final Result"::Pass)
                //    END ELSE BEGIN
                //      Rec.VALIDATE("Final Result",Rec."Final Result"::Fail);
                //    END;
                //  END;
                // END;
                // IF Rec."Lab Code" = '' THEN
                //  Rec.VALIDATE("Final Result",Rec."Final Result"::" ");
            end;
        }
        field(3; "Got Result"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(4; "BT/Elisa Result"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(5; "STL 1 Result"; Option)
        {
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(6; "STL 2 Result"; Option)
        {
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(7; "STL 3 Result"; Option)
        {
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(8; "Final Result"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;

            trigger OnValidate()
            begin
                IF Rec."Final Result" <> Rec."Final Result"::" " THEN BEGIN
                    Rec."Final Date of Testing" := TODAY;
                    Rec."Final Result User id" := USERID;
                END;
                IF Rec."Final Result" = Rec."Final Result"::" " THEN BEGIN
                    Rec."Final Date of Testing" := 0D;
                    Rec."Final Result User id" := '';
                END;
            end;
        }
        field(9; "Final Date of Testing"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Reason; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '//for FAIL CONDITION';
        }
        field(11; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Got test User"; Text[30])
        {
            Editable = false;
        }
        field(13; "Got Test Date"; Date)
        {
            Editable = false;
        }
        field(14; "BT/Elisa Test User"; Text[30])
        {
            Editable = false;
        }
        field(15; "BT/Elisa Test Date"; Date)
        {
            Editable = false;
        }
        field(16; "STL 1 Test User"; Text[30])
        {
            Editable = false;
        }
        field(17; "STL 1 Test Date"; Date)
        {
            Editable = false;
        }
        field(18; "STL 2 Test User"; Text[30])
        {
            Editable = false;
        }
        field(19; "STL 2 Test Date"; Date)
        {
            Editable = false;
        }
        field(20; "STL3 test User"; Text[30])
        {
            Editable = false;
        }
        field(21; "STL 3 Test Date"; Date)
        {
            Editable = false;
        }
        field(22; "Final Result User id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; Invalid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Invalid User Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(26; "Bute No."; Code[20])
        {
            Editable = false;
        }
        field(27; "Item No."; Code[20])
        {
            CalcFormula = Lookup("Got Testing Master"."Item No." WHERE("Sample Code" = FIELD("Lab Code"),
                                                                        Invalid = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Item Product Group Code"; Code[100])
        {
            CalcFormula = Lookup(Item."Crop Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Item Class of Seeds"; Option)
        {
            CalcFormula = Lookup(Item."Class of Seeds" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Class of Seeds';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(31; "Final Result Posting Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Crop Code"; Code[20])
        {
            Editable = false;
        }
        field(33; "NAOH Result"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(34; "EC Result"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(35; "Chlorophyll Result"; Option)
        {
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(36; "Phenol Result"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(37; "Soil Emergence AAT Result"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(38; "HT Result"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Fail,Pass';
            OptionMembers = " ",Fail,Pass;
        }
        field(39; "Generic Purity Result"; Option)
        {
            // CalcFormula = Lookup("AAT Test".Result WHERE("Sample Code" = FIELD("Lab Code"),
            //                                               Invalid = FILTER(false),
            //                                               Posted = FILTER(Yes)));
            // Editable = false;
            // FieldClass = FlowField;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(40; "Season Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Variant Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Source ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Foundation Process,Hybrid Process,Organizer Process,Foundation SA,Hybrid SA,Opening Entry';
            OptionMembers = " ","Foundation Process","Hybrid Process","Organizer Process","Foundation SA","Hybrid SA","Opening Entry";
        }
        field(47; "Receipt No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "NAOH Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "NAOH Test User"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "EC Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "EC Test User"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "ChlorophyII Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "ChlorophyII Test User"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Phenol Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Phenol Test User"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Soil & AAT Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Soil & AAT Test User"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "HT Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "HT Test User"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(61; "Qty Kg"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Item Group"; Code[100])
        {
            CalcFormula = Lookup(Item."Variety Code" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(64; "Received Date Time"; DateTime)
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
        key(Key2; "Lab Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Lab Code")
        {
        }
    }

    trigger OnInsert()
    var
        recUL: Record "User Location";
        recloc: Record Location;
    begin
        IF "No." = '' THEN BEGIN
            recUL.RESET;
            recUL.SETCURRENTKEY("User ID");
            recUL.SETRANGE("User ID", USERID);
            recUL.SETRANGE("QC Result Declaration", TRUE);
            IF recUL.FINDFIRST THEN BEGIN
                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                    recLoc.TESTFIELD("QC Result Declara. No.");
                    //NoSeriesMgt.TestManual(recLoc."PPD Series");
                    "No. Series" := '';
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("QC Result Declara. No."));
            END ELSE
                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
        END;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        recUL: Record 50015;
        recPurchAndPayableSetup: Record 312;
        InvtrySetup: Record 313;
}

