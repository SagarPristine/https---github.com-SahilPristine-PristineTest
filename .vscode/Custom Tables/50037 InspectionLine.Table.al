table 50037 "Inspection Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Type; Enum "Inspection Types")
        {
            DataClassification = ToBeClassified;
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
        field(9; "Variety Code"; Code[20])
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
        field(38; "Season Code"; Code[10])
        {
            TableRelation = "Season Master"."Season Code";
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
        field(56; "Date of Sowing"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of Sowing (for both female and male) ';
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
        field(50000; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Revised Yield(RAW)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Inspection I"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Inspection II"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Inspection III"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Inspection IV"; Boolean)
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
        field(50026; "Sowing Area in Acres"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Date of sowing Male"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Date of sowing Female"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Date of visit"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Ramarks"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Date of Transplanting"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Net Standing Area (in Acres)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Seedling Age of Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Soil Type"; Option)
        {
            OptionMembers = " ",Black,Red,Mix;

        }
        field(50035; "Previous Crop Nursery"; Text[50])
        {
            InitValue = NP;
        }
        field(50036; "Previous Crop: Main Field"; Text[50])

        {
            InitValue = NP;
        }
        field(50037; "North"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "North Border Male Barrier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "East"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "East Border Male Barrier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "South"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "South Border Male Barrier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "West"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "West Border Male Barrier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Planned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Preflowering Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Preflowering Roughing Completion Date';
        }
        field(50047; "No. of OT in 1000 Hill"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Types of OT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Pollination Complete Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Time isolation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Nick Status"; Option)
        {
            OptionMembers = " ",A2,D2;
        }
        field(50054; "Target Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Actual Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; Deviation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Final Roughing Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Harvesting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "PLD / Cancellation Area"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "PLD / Cancellation Reason"; option)

        {
            OptionMembers = " ",Colour,ODV,Others;
        }
        field(50061; "Expected Arrival Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Expected Arrival Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Actual number of bags"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Actual tare weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Yield Per Acre"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "BSIO/FSIO"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", Type, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        VarAvgCrossBollsperPlant: Decimal;
        Item: Record 27;
}

