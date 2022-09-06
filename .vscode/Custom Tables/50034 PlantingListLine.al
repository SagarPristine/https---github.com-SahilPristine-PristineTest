table 50034 "Planting List Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(2; "Organizer Code"; Code[20])
        {
            CalcFormula = Lookup("Planting List Header"."Organiser Code" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Vendor WHERE("Vendor Type" = FILTER(Organizer | Grower));

            trigger OnValidate()
            begin

            end;
        }
        field(3; "Organizer Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Organizer Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Organizer Name 2"; Text[50])
        {
            CalcFormula = Lookup(Vendor."Name 2" WHERE("No." = FIELD("Organizer Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Farmer Code"; Code[20])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(6; Name; Text[30])
        {
        }
        field(7; "Name 2"; Text[30])
        {
        }
        field(8; "Crop Code"; Code[20])
        {
            TableRelation = "Crop Master".Code;
        }
        field(9; "Variety Code"; Code[10])
        {
            TableRelation = Varieties."Variety Code" where("Variety Code" = field("Item No."));
            Editable = false;
        }
        field(10; "Contracted Acres"; Decimal)
        {
        }
        field(14; "Parent Seed Quantity (Male)"; Decimal)
        {
        }
        field(15; "Parent Seed Quantity (Female)"; Decimal)
        {
        }
        field(16; "Date of Male Sowing"; Date)
        {

            trigger OnValidate()
            begin


            end;
        }
        field(17; "Date of Female Sowing"; Date)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(18; "Vegetative Date (Expected)"; Date)
        {
        }
        field(19; "Flowering Date (Expected)"; Date)
        {
        }
        field(20; "Grain Filling (Expected)"; Date)
        {
        }
        field(21; "Harvest Start Date (Expected)"; Date)
        {
        }
        field(23; "Vegetative Date (Actual)"; Date)
        {
        }
        field(24; "Flowering Date (Actual)"; Date)
        {
        }
        field(25; "Green Filling (Actual)"; Date)
        {
        }
        field(26; "Harvest Start Date (Actual)"; Date)
        {
        }
        field(27; "Harvest End Date (Actual)"; Date)
        {
        }
        field(28; "Sowing Acres"; Decimal)
        {
        }
        field(29; "Rejected Acres"; Decimal)
        {
        }
        field(30; "Harvested Acres"; Decimal)
        {
        }
        field(31; "Lot No. (Male)"; Code[20])
        {
        }
        field(32; "Lot No. (Female)"; Code[20])
        {
        }
        field(33; "Assigned Lot No."; Code[20])
        {
        }
        field(34; "Pay-to Type"; Option)
        {
            OptionMembers = Organiser,Farmer;
        }
        field(36; "Parent Seed Code (Male)"; Code[20])
        {
        }
        field(37; "Parent Seed Code (Female)"; Code[20])
        {

        }
        field(38; "Season Code"; Code[20])
        {
            TableRelation = "Season Master"."Season Code";
        }
        field(39; "Line No."; Integer)
        {
        }
        field(40; "Field Assistant"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }

        field(42; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(43; "Seed Type"; Option)
        {
            OptionCaption = ' ,Commercial,Foundation,Breeder';
            OptionMembers = " ",Commercial,Foundation,Breeder;
        }
        field(44; "Grower Village"; Text[100])
        {
            CalcFormula = Lookup(Growers.Village WHERE("No." = FIELD("Grower Owner")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Grower Taluka/Mandal"; Code[20])
        {
            CalcFormula = Lookup(Growers.Taluka WHERE("No." = FIELD("Grower Owner")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Taluka Master".Code;
        }
        field(46; "Grower District"; Code[20])
        {
            CalcFormula = Lookup(Growers.District WHERE("No." = FIELD("Grower Owner")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "District Master".Code;
        }
        field(47; Remarks; Text[120])
        {
        }
        field(48; "Soaking Dates Female"; Date)
        {
        }
        field(49; "Sowing Date Male II"; Date)
        {
        }
        field(50; "Sowing Date Other"; Date)
        {
        }
        field(51; "Sowing Date Male III"; Date)
        {
        }
        field(52; "Transplanting Dates Male"; Date)
        {
        }
        field(53; "Transplanting Dates Female"; Date)
        {
        }
        field(54; "Standing Area In Acres"; Decimal)
        {
        }
        field(55; "Soaking Dates"; Date)
        {
        }
        field(56; "Sowing Date"; Date)
        {
        }
        field(57; "Production Location"; Code[20])
        {
        }
        field(58; "Sowing Date Male"; Date)
        {
        }
        field(60; Posted; Boolean)
        {
        }
        field(62; "Grower Owner"; Code[20])
        {
            Caption = 'Grower/Land Owner';
            TableRelation = Growers."No.";

            trigger OnValidate()
            var
                recGrower: Record Growers;
                recParentSeedMaster: Record "Parent Seed Master";
            begin
                IF recGrower.GET("Grower Owner") THEN BEGIN
                    "Grower/Land Owner Name" := recGrower.Name;
                    "Grower Taluka/Mandal" := recGrower.Taluka;
                    "Grower District" := recGrower.District;
                END ELSE BEGIN
                    "Grower/Land Owner Name" := '';
                    "Grower Taluka/Mandal" := '';
                    "Grower District" := '';
                END;


                recParentSeedMaster.RESET;
                recParentSeedMaster.SETCURRENTKEY("Variety Type");
                recParentSeedMaster.SETRANGE("Variety Code", "Variety Code");
                IF recParentSeedMaster.FINDSET THEN BEGIN
                    Rec."Variety Code(Male)" := recParentSeedMaster."Parent Seed Code(Male)";
                    Rec."Variety Code(Female)" := recParentSeedMaster."Parent Seed Code(Female)";
                    Rec."Variety Code(Other)" := recParentSeedMaster."Parent Seed Code(Other)";
                    Rec."Variety Code(Male Name)" := recParentSeedMaster."Parent Seed Name(Male)";
                    Rec."Variety Code(Female Name)" := recParentSeedMaster."Parent Seed Name(Female)";
                    Rec."Variety Code(Other Name)" := recParentSeedMaster."Parent Seed Name(Other)";
                END;
            end;
        }
        field(63; "Grower/Land Owner Name"; Text[80])
        {
            Caption = 'Grower/Land Owner Name';
        }
        field(64; "Variety Code(Male)"; Code[20])
        {
        }
        field(65; "Variety Code(Female)"; Code[20])
        {
        }
        field(66; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Variety Code"));
        }
        field(67; "Base Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Variety Code"));
        }
        field(68; "Unit of Measure"; Code[20])
        {
        }
        field(69; "Qty. Per Unit Of Measure"; Decimal)
        {
        }
        field(70; "Sowing Date Female"; Date)
        {
        }
        field(71; "Got Recommended"; Boolean)
        {
        }
        field(72; "Rejected In Inspection"; Boolean)
        {
        }
        field(73; "Contract No."; Code[20])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(74; "Village Name"; Text[30])
        {
        }
        field(75; "Hybrid Type"; Option)
        {
            OptionMembers = " ","OP Hybrid","Hybrid Paddy",Others;
        }
        field(76; "Sowing Area In R"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                PlantingListHeader: Record "Planting List Header";
            begin

            end;
        }
        field(77; "Production Centre Name"; Text[50])
        {
        }
        field(78; "Stand Area(Preflowring)"; Decimal)
        {
        }
        field(79; "Stand Area(Flowring)"; Decimal)
        {
        }
        field(80; "Stand Area(Harvesting)"; Decimal)
        {
        }
        field(81; "Vegetative Stage Posted"; Boolean)
        {
        }
        field(82; "PreFlowring Stage Posted"; Boolean)
        {
        }
        field(83; "Flowring Stage Posted"; Boolean)
        {
        }
        field(84; "Harvesting Stage Posted"; Boolean)
        {
        }
        field(85; "Expected Yield"; Decimal)
        {
        }
        field(86; "Total Expected Yield"; Decimal)
        {
        }
        field(87; "CT Start Date"; Date)
        {
        }
        field(88; "CT End Date"; Date)
        {
        }
        field(89; "50% Flowing Date"; Date)
        {
        }
        field(90; "Date of Harvest"; Date)
        {
        }
        field(91; "Production Lot No."; Code[20])
        {
            Caption = 'Production Lot No.';
        }
        field(92; "Receipt No."; Code[20])
        {
        }
        field(93; "Sowing Area"; Decimal)
        {
        }
        field(94; "Receipt Ceated"; Boolean)
        {
        }
        field(50000; "No. of Bags"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Revised Yield(RAW)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Nursery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vegetative"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Isolation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Pre-Flowering"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Item Class of Seeds"; Option)
        {
            CalcFormula = Lookup(Item."Class of Seeds" WHERE("No." = FIELD("Variety Code")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(50010; "Item Crop Type"; Option)
        {
            CalcFormula = Lookup(Item."Crop Type" WHERE("No." = FIELD("Variety Code")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Hybrid,Improved,Inbred,Tissue Culture,Non Hybrid';
            OptionMembers = " ",Hybrid,Improved,Inbred,"Tissue Culture","Non Hybrid";
        }
        field(50011; "Inspection QC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; Zone; Code[20])
        {
            CalcFormula = Lookup(Vendor.Zone WHERE("No." = FIELD("Organizer Code"),
                                                    "Vendor Type" = FILTER(Organizer)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "State Code"; Code[20])
        {
            CalcFormula = Lookup(Vendor."State Code" WHERE("No." = FIELD("Organizer Code"),
                                                           "Vendor Type" = FILTER(Organizer)));
            Caption = 'State Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = State.Code;
        }
        field(50016; "District Code"; Code[20])
        {
            CalcFormula = Lookup(Vendor.District WHERE("No." = FIELD("Organizer Code"),
                                                               "Vendor Type" = FILTER(Organizer)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "District Master".Code;
        }
        field(50017; Region; Code[20])
        {
            CalcFormula = Lookup(Vendor.Region WHERE("No." = FIELD("Organizer Code"),
                                                             "Vendor Type" = FILTER(Organizer)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Region Master".Code;
        }
        field(50018; Taluka; Code[20])
        {
            CalcFormula = Lookup(Vendor.Taluka WHERE("No." = FIELD("Organizer Code"),
                                                      "Vendor Type" = FILTER(Organizer)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Taluka Master".Code;
        }
        field(50019; "Zone Name"; Text[100])
        {
            CalcFormula = Lookup("Zone Master".Description WHERE(Code = FIELD(Zone)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "State Name"; Text[100])
        {
            CalcFormula = Lookup(State.Description WHERE(Code = FIELD("State Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "District Name"; Text[100])
        {
            CalcFormula = Lookup("District Master".Name WHERE(Code = FIELD("District Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Region Name"; Text[100])
        {
            CalcFormula = Lookup("Region Master".Name WHERE(Code = FIELD(Region)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Taluka Name"; Text[100])
        {
            CalcFormula = Lookup("Taluka Master".Description WHERE(Code = FIELD(Taluka)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Planting Document Date"; Date)
        {
            CalcFormula = Lookup("Planting List Header".Date WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; Counter; Text[50])
        {

            Description = 'PBS-SAG';
        }
        field(50031; "Nursery Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Vegetative Status"; enum "Inspection Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50033; "Isolation Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50034; "Pre-Flowering Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50039; "Flowering Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50007; "Pollination Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50040; "MaleChopping Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50041; "Final Roughing Status"; enum "Inspection Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50042; "Harvesting Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Vegetative Roughing Status"; Enum "Inspection Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Document SubType"; Enum "Document Subtype")
        {
            DataClassification = ToBeClassified;

        }
        field(50048; "BSIO No."; Code[20])
        {
            Caption = 'BSIO/FSIO No.';
            TableRelation = "Sales Shipment Header"."No." where("Document SubType" = field("Document SubType"));
            trigger OnValidate()
            var
                rec50017: Record "Planting List Header";
                SalesInvoiceHeader: Record 110;
                recSIL: Record 113;
                rec50018: Record 50018;
                recParentSeedMaster: Record "Parent Seed Master";
            begin
                IF Rec."BSIO No." <> '' THEN BEGIN
                    IF rec50017.GET(Rec."Document No.") THEN
                        Rec."Organizer Code" := rec50017."Organiser Code";
                END;

            end;
        }
        field(50046; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Line"."Line No." where("Document No." = field("BSIO No."));
        }

        field(50049; "Crop Name"; Text[100])
        {
            CalcFormula = Lookup("Crop Master".Description WHERE("Code" = FIELD("Crop Code")));
            FieldClass = FlowField;
        }
        field(50050; "Variety Code(Other)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Variety Code(Male Name)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Variety Code(Female Name)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Variety Code(Other Name)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Seed Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Issued area in acre"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Net standing area in acre "; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Production officer"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "TFS"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Flowering"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "MaleChopping"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Final Roughing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Harvesting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; Pollination; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Vegetative Roughing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Line No.", "Production Lot No.")
        {
        }
    }

    trigger OnDelete()
    begin
        /*
        SowingHeader.SETRANGE(SowingHeader."No.","Document No.");
        SowingHeader.SETRANGE(SowingHeader.Status,SowingHeader.Status::Release);
        IF SowingHeader.FIND('-') THEN
          ERROR('You cannot Delete record because sowing status is release')
        */

    end;

    trigger OnInsert()
    begin

        GetHeader;
        SowingHeader.SETRANGE(SowingHeader."No.", "Document No.");
        SowingHeader.SETRANGE(SowingHeader.Status, SowingHeader.Status::Release);
        IF SowingHeader.FIND('-') THEN
            ERROR('You cannot insert record because sowing status is release')
    end;

    var
        //FieldProductionSetup: Record "50008";
        Item: Record 27;
        FSIOHeader: Record 36;
        SowingHeader: Record "Planting List Header";
        FSIOLine: Record 37;
        SowingReportLine: Record "Planting List Line";

    procedure CalcExpecteddate(SowingDate: Date)
    begin
    end;

    procedure GetHeader()
    begin
        SowingHeader.SETRANGE(SowingHeader."No.", "Document No.");
        IF SowingHeader.FIND('-') THEN BEGIN
            SowingHeader.TESTFIELD(SowingHeader.Season);
            SowingHeader.TESTFIELD(SowingHeader."Production Centre");

            "Season Code" := SowingHeader.Season;
            "Production Location" := SowingHeader."Production Centre";
            "Production Centre Name" := SowingHeader."Production Centre Name";

        END;
    end;
}

