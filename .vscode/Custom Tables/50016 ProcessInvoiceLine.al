table 50016 "Process Invoice Line"
{

    fields
    {
        field(1; "Pre Document No."; Code[20])
        {
            Caption = 'Pre Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "Process Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "From Bute No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "From Bin/Stack Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Total Avai. Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(7; "Required Bags"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Required Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(9; "Good No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Good Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(11; "S Qty.(Crop Code)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Lint No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Lint Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(14; "Process Loss Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Marketing Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//To Packed Stage Only';
        }
        field(16; "Packed Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//To Packed Stage Only';
        }
        field(17; "Packing By"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '//To Packed Stage Only';
        }
        field(18; "Quality Test Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//To Packed Stage Only';
        }
        field(19; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//To Packed Stage Only';
        }
        field(20; "Lint Bin/Stack Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Post Document No."; Code[20])
        {
            Caption = 'Post Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "Process Header"."No.";
        }
        field(23; "To Bin/Stack Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            Description = '//For filtering "From Bin/Stack Code" & "To Bin/Stack Code"';
        }
        field(26; "From Stage"; Code[50])
        {
            Caption = 'From Stage';
            DataClassification = ToBeClassified;
            Description = '//For filtering "From Bin/Stack Code" & "To Bin/Stack Code"';
        }
        field(27; "To Stage"; Code[50])
        {
            Description = '//"To Bin/Stack Code"';
            Editable = false;
        }
        field(28; "ILE Document No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '//For filtering "From Bin/Stack Code"';
        }
        field(29; "Remenant No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Remenant Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(31; "Remenant Bin/Stack Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Location Code"; Code[20])
        {
            CalcFormula = Lookup("Process Invoice Header".Location WHERE("Process Transfer Post No." = FIELD("Post Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Released Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; RVD; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//For Tracking RVD';
            Editable = false;
        }
        field(35; "To Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

        }
        field(36; "To Location Name"; Text[100])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("To Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Unit of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
            TableRelation = "Unit of Measure";
        }
        field(38; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
            OptionMembers = " ",Output,Consumption;
        }
        field(39; "Bom No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
        }
        field(40; "Complete Bom Calculation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
        }
        field(41; "Consumption Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
        }
        field(42; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
        }
        field(43; "All Label"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
        }
        field(44; Sample; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
        }
        field(45; "packing Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PBS-SAGAR';
        }
        field(46; "Label No.-1 From"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(47; "Label No.-1 To"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(48; "Cancel Label"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(49; "Total Label"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(50; "Label No.-2 From"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(51; "Label No.-2 To"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(52; "Label No.-3 From"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(53; "Label No.-3 To"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
        }
        field(54; "Special Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Sample No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';

            trigger OnValidate()
            var
                recProcessHeader: Record 50014;
            begin
            end;
        }
        field(56; "Sample Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = '//For cleanin to pack only';
        }
        field(57; "Sample Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            var
                recUL: Record 50018;
                ProcessTransferPostYesNo: Codeunit 50000;
            begin
            end;
        }
        field(58; "Sample Location Name"; Text[100])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Sample Location Code")));
            Description = '//For cleanin to pack only';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Sample Bin Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Sample Location Code"));
        }
    }

    keys
    {
        key(Key1; "Post Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

