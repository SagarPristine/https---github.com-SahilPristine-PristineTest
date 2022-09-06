table 50020 "Delivery Sales Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.get("Customer No.") then begin
                    Customer.SetAutoCalcFields("Zone Name", "Taluka Name", "District Name", "Region Name");
                    "Customer Name" := Customer.Name + ' ' + Customer."Name 2";
                    "Sell-to Address" := Customer.Address;
                    "Sell-to address 2" := Customer."Address 2";
                    "Post Code" := Customer."Post Code";
                    City := Customer.City;
                    Zone := Customer.Zone;
                    "Zone Name" := Customer."Zone Name";
                    Taluka := Customer.Taluka;
                    "Taluka Name" := Customer."Taluka Name";
                    District := Customer.District;
                    "District Name" := Customer."District Name";
                    Region := Customer.Region;
                    "Region Name" := Customer."Region Name";
                    "State Code" := Customer."State Code";
                    "Country/Region Code" := Customer."Country/Region Code";
                end else begin
                    "Customer Name" := '';
                    "Sell-to Address" := '';
                    "Sell-to address 2" := '';
                    "Post Code" := '';
                    City := '';
                    Zone := '';
                    "Zone Name" := '';
                    Taluka := '';
                    "Taluka Name" := '';
                    District := '';
                    "District Name" := '';
                    Region := '';
                    "Region Name" := '';
                    "State Code" := '';
                    "Country/Region Code" := '';
                end;
            end;
        }
        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Sell-to Address"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Sell-to address 2"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "City"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code".City;

        }
        field(7; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code".Code;

        }
        field(8; "Country/Region Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

        }
        field(9; "Season"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";

        }
        field(50000; Zone; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Zone Master".Code;
        }
        field(50001; District; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "District Master".Code;
        }
        field(50002; Region; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Region Master".Code;
        }
        field(50003; Taluka; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Taluka Master".Code;
        }

        field(50005; "Zone Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Zone Master".Description where(Code = field(Zone)));
        }
        field(50006; "Taluka Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Taluka Master".Description where(Code = field(Taluka)));
        }
        field(50007; "Region Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Region Master".Name where(Code = field(Region)));
        }
        field(50008; "District Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("District Master".Name where(Code = field(District)));
        }
        field(50009; "Marketing indent No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50010; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50011; "Requested Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50012; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

        }
        field(50013; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = State.Code;
        }
        field(50015; Status; Enum "Sales Document Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Document SybType"; Enum "Document Subtype")
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Child Seed"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Parent Seed Master"."Variety Code" WHERE("Variety Type" = FIELD("Child Seed Type"));
            trigger OnValidate()
            var
                recsl: Record "Delivery Sales line";
                Lineno: Integer;
                recParentSeed: Record "Parent Seed Master";
            begin
                CLEAR(lineno);
                IF Rec."Child Seed" = '' THEN BEGIN
                    recSL.RESET;
                    recSL.SETCURRENTKEY("Document No.");
                    recSL.SETRANGE("Document No.", Rec."No.");
                    IF recSL.FINDSET THEN
                        recSL.DELETEALL;
                END ELSE
                    IF Rec."Child Seed" <> '' THEN BEGIN
                        Rec.TESTFIELD("Child Seed Type");
                        recParentSeed.RESET;
                        IF recParentSeed.GET(Rec."Child Seed Type", Rec."Child Seed") THEN BEGIN
                            IF recParentSeed."Parent Seed Code(Male)" <> '' THEN BEGIN
                                lineno += 10000;
                                CreateSalesLine(lineno, 'Male');
                            END;
                            IF recParentSeed."Parent Seed Code(Female)" <> '' THEN BEGIN
                                lineno += 10000;
                                CreateSalesLine(lineno, 'Female');
                            END;
                            IF recParentSeed."Parent Seed Code(Other)" <> '' THEN BEGIN
                                lineno += 10000;
                                CreateSalesLine(lineno, 'Other');
                            END;
                        END ELSE
                            ERROR('Parent Seed No. does not exits.');
                    END;
            end;
        }
        field(50018; "Child Seed Type"; Option)
        {
            OptionMembers = " ",Breeder,Foundation,Hybrid,Improved;
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
        fieldgroup(DropDown; "No.", "Customer No.", "Customer Name", "Sell-to Address", "Sell-to address 2", "Location Code", Season, "Order Date") { }
    }

    var
        myInt: Integer;



    trigger OnInsert()
    var
        recloc: Record Location;
        NoSeriesMgt: Codeunit 396;
    begin
        IF "No." = '' THEN BEGIN
            IF "Location Code" <> '' THEN BEGIN
                IF recLoc.GET("Location Code") THEN BEGIN
                    recLoc.TESTFIELD("Delivery Order No. Series");
                    NoSeriesMgt.InitSeries(recLoc."Delivery Order No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                    Rec."Location Code" := "Location Code";
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recLoc.Code, recLoc.FIELDCAPTION("Delivery Order No. Series"));
            END;
        END;
    END;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure CreateSalesLine(LineNo: Integer; "Male/Female/Other": Text)
    var
        recps: Record "Parent Seed Master";
        recsl: Record "Delivery Sales line";
        recile: Record "Item Ledger Entry";
        recitem: Record Item;
    begin
        IF recPS.GET(Rec."Child Seed Type", Rec."Child Seed") THEN BEGIN
            recSL.RESET;
            recSL.INIT;
            recSL."Document No." := Rec."No.";
            recSL."Line No." := LineNo;

            IF "Male/Female/Other" = 'Male' THEN
                if recitem.Get(recps."Parent Seed Code(Male)") then
                    recsl."Crop Code" := recitem."Crop Code";
            IF "Male/Female/Other" = 'Female' THEN
                if recitem.Get(recps."Parent Seed Code(Female)") then
                    recsl."Crop Code" := recitem."Crop Code";
            IF "Male/Female/Other" = 'Other' THEN
                if recitem.Get(recps."Parent Seed Code(Other)") then
                    recsl."Crop Code" := recitem."Crop Code";

            IF "Male/Female/Other" = 'Male' THEN
                recSL.VALIDATE(recsl."Item No.", recPS."Parent Seed Code(Male)");
            IF "Male/Female/Other" = 'Female' THEN
                recSL.VALIDATE(recsl."Item No.", recPS."Parent Seed Code(Female)");
            IF "Male/Female/Other" = 'Other' THEN
                recSL.VALIDATE(recsl."Item No.", recPS."Parent Seed Code(Other)");
            IF recItem.GET(recSL."Item No.") THEN BEGIN
                recILE.RESET;
                recILE.SETCURRENTKEY("Item No.", "Class of Seeds", "Crop Code", "Variant Code", "Remaining Quantity");
                recILE.SETRANGE("Item No.", recItem."No.");
                recILE.SETFILTER("Variant Code", '%1', 'PACKED');
                recILE.SETFILTER("Remaining Quantity", '>0');
                IF recILE.FINDFIRST THEN
                    recsl.validate("No. of bags", recile."Remaining Quantity" / recitem."FG Pack Size")
            END ELSE
                ERROR('Item Ledger Entry doesnot have Stock for Item No. %1, Crop Code %2, Stage "PACKED" & Quantity greater than Zero.', recItem."No.");
        END;
        recSL.INSERT;
    END;
}