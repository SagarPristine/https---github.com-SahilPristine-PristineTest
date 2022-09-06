table 50017 "Process Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
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
            Caption = 'Lot No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                rec50007: Record 50014;
                rec32: Record 32;
                InventorySetup: Record 313;
                ProcessLine: Record 50017;
            begin
                IF Rec."From Bute No." <> '' THEN BEGIN
                    // ProcessLine.RESET;
                    // ProcessLine.SETCURRENTKEY("Document No.", "Line No.");
                    // ProcessLine.SETRANGE("Document No.", Rec."Document No.");
                    // IF ProcessLine.FINDSET THEN BEGIN
                    //     REPEAT
                    //         IF ProcessLine."From Bute No." = Rec."From Bute No." THEN
                    //             ERROR('Bute No. %1 already selected.', Rec."From Bute No.");
                    //     UNTIL ProcessLine.NEXT = 0;
                    // END;

                    rec50007.RESET;
                    rec50007.GET(Rec."Document No.");
                    Rec."Item No." := rec50007."Item No.";
                    Rec."From Stage" := rec50007."From Stage";
                    Rec."To Stage" := rec50007."To Stage";

                    //RequiredQty
                    //     rec32.RESET;
                    //     rec32.SETCURRENTKEY("Item No.", "Crop Code", "Variant Code", "Lot No.", "Location Code");
                    //     rec32.SETRANGE("Item No.", Rec."Item No.");
                    //     rec32.SETRANGE("Crop Code", rec50007."Crop Code");
                    //     rec32.SETRANGE("Variant Code", Rec."From Stage");
                    //     rec32.SETFILTER("Entry Type", '%1|%2|%3', rec32."Entry Type"::"Positive Adjmt.", rec32."Entry Type"::Purchase, rec32."Entry Type"::Transfer);
                    //     rec32.SETFILTER("Remaining Quantity", '>0');
                    //     rec32.SETRANGE("Location Code", rec50007.Location);
                    //     rec32.SETRANGE("Lot No.", Rec."From Bute No.");
                    //     rec32.SETRANGE("Document No.", Rec."ILE Document No.");
                    //     IF rec32.FINDFIRST THEN BEGIN
                    //         Rec."No. of Bags/Pckt" := rec32."No. of Bags/Pckt";
                    //         Rec."Total Avai. Qty." := rec32."Remaining Quantity";
                    //         Rec."Required Bags" := rec32."No. of Bags/Pckt";
                    //         Rec."Required Qty." := rec32."Remaining Quantity";
                    //         Rec.RVD := rec32.RVD;
                    //         BinContent.RESET;
                    //         BinContent.SETRANGE("Location Code", rec50007.Location);
                    //         BinContent.SETRANGE("Lot No. Filter", "From Bute No.");
                    //         BinContent.SETFILTER(Quantity, '<>%1', 0);
                    //         BinContent.FINDFIRST;
                    //         Rec.VALIDATE("From Bin/Stack Code", BinContent."Bin Code");
                    //         Rec.VALIDATE("Lint Bin/Stack Code", BinContent."Bin Code");
                    //         Rec.VALIDATE("Remenant Bin/Stack Code", BinContent."Bin Code");
                    //         Rec.VALIDATE("To Bin/Stack Code", BinContent."Bin Code");
                    //         Rec.VALIDATE("Unit of Measure Code", rec32."Unit of Measure Code");
                    //         Rec.MODIFY;
                    //     END;
                    // END ELSE
                    IF Rec."From Bute No." = '' THEN BEGIN
                        Rec."From Bin/Stack Code" := '';
                        CLEAR(Rec."No. of Bags/Pckt");
                        CLEAR(Rec."Total Avai. Qty.");
                        CLEAR(Rec."Required Bags");
                        CLEAR(Rec."Required Qty.");
                        CLEAR(Rec."Packed Item Code");
                        CLEAR(Rec."Marketing Lot No.");
                        CLEAR(Rec."Packing By");
                        CLEAR(Rec.RVD);
                        CLEAR(Rec."From Bin/Stack Code");
                        CLEAR(Rec."Lint Bin/Stack Code");
                        CLEAR(Rec."Remenant Bin/Stack Code");
                        CLEAR(Rec."To Bin/Stack Code");
                    END;
                end;
            end;
        }
        field(4; "From Bin/Stack Code"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                rec32: Record 32;
                rec50007: Record 50007;
            begin
            end;
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

            trigger OnValidate()
            var
                recProcessHeader: Record 50014;
            begin
                IF Rec."Good No. of Bags/Pckt" <> 0 THEN BEGIN
                    //Get Process Header Details
                    recProcessHeader.RESET;
                    IF NOT recProcessHeader.GET(Rec."Document No.") THEN
                        ERROR('Process Header %1 doesnot found.', Rec."Document No.");

                    //Calculate GoodQty. for Cleaning to Packed Item
                    IF recProcessHeader."To Stage" = 'PACKED' THEN BEGIN
                        Rec.TESTFIELD("Packed Item Code");
                        rec27.RESET;
                        IF NOT rec27.GET(Rec."Packed Item Code") THEN
                            ERROR('Unable to get details of Item No. %1', Rec."Packed Item Code");
                        Rec.VALIDATE("Good Qty.", (rec27."FG Pack Size" * Rec."Good No. of Bags/Pckt"));
                    END;
                END;

                IF Rec."Good No. of Bags/Pckt" = 0 THEN
                    Rec."Good Qty." := 0;
            end;
        }
        field(10; "Good Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Process Loss Qty.", (Rec."Required Qty." - (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty.")));
                IF (Rec."Required Qty." < (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty." + Rec."Process Loss Qty.")) THEN
                    ERROR('Quantity taken should be less than Avai. Quantity.');
            end;
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

            trigger OnValidate()
            begin
                Rec.VALIDATE("Process Loss Qty.", (Rec."Required Qty." - (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty.")));
                IF (Rec."Required Qty." < (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty." + Rec."Process Loss Qty.")) THEN
                    ERROR('Quantity taken should be less than Avai. Quantity.');
            end;
        }
        field(14; "Process Loss Qty."; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF (Rec."Required Qty." < (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty." + Rec."Process Loss Qty.")) THEN
                    ERROR('Quantity taken should be less than Avai. Quantity.');
                IF (Rec."Process Loss Qty." < 0) THEN
                    ERROR('Process Loss Quantity cannot be negative.');
            end;
        }
        field(15; "Marketing Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//For Packing Stage Only';

            trigger OnValidate()
            var
                ItemLedgerEntry: Record 32;
            begin
            end;
        }
        field(16; "Packed Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//For Packing Stage Only';
            TableRelation = Item."No." WHERE("Class of Seeds" = FILTER(TL | Foundation | Breeder));

            trigger OnValidate()
            var
                //    recLotRangeMaster: Record 50019;
                recProcessHeader: Record 50014;
            // QCResultDeclaration: Record 50032;
            begin
                IF (Rec."Packed Item Code" <> '') AND (Rec.RVD = FALSE) THEN BEGIN
                    Rec.CALCFIELDS("Location Code");

                    //Get Process Header Details
                    recProcessHeader.RESET;
                    IF NOT recProcessHeader.GET(Rec."Document No.") THEN
                        ERROR('Process Header %1 doesnot found.', Rec."Document No.");

                    //for "Marketing Lot No" & "Date of Test"
                    //Comment by sagar
                    /*
                    rec27.RESET;
                    IF rec27.GET(recProcessHeader."Item No.") THEN BEGIN
                        IF rec27."Class of Seeds" = rec27."Class of Seeds"::Breeder THEN BEGIN //for Breeder
                            recProcessHeader.CALCFIELDS("Supervisor Name");
                            Rec.VALIDATE("Packing By", recProcessHeader."Supervisor Name");
                            //for "Date of Test"
                        END ELSE
                            IF (rec27."Class of Seeds" <> rec27."Class of Seeds"::Breeder) AND ("Special Approval" = FALSE) THEN BEGIN //for other than breeder
                                recProcessHeader.CALCFIELDS("Supervisor Name");
                                Rec.VALIDATE("Packing By", recProcessHeader."Supervisor Name");

                                //      //for "Date of Test"
                                //        GerminationEvaluation.RESET;
                                //        GerminationEvaluation.SETRANGE("Bute No.",Rec."From Bute No.");
                                //        IF GerminationEvaluation.FINDLAST THEN
                                //          IF GerminationEvaluation.Results <> GerminationEvaluation.Results::Pass THEN
                                //            ERROR('Please declare Germination. It looks like you havenot declared it yet.')
                                //          ELSE
                                //        Rec.VALIDATE("Quality Test Date",GerminationEvaluation."Date of Test");
                            END;
                    END;
                    */
                    //Comment by sagar
                END;


                //for RVD
                IF (Rec."Packed Item Code" <> '') AND (Rec.RVD = TRUE) THEN BEGIN
                    Rec.VALIDATE("Marketing Lot No.", Rec."From Bute No.");
                    recProcessHeader.CALCFIELDS("Supervisor Name");
                    Rec.VALIDATE("Packing By", recProcessHeader."Supervisor Name");
                END;

                IF Rec."Packed Item Code" = '' THEN BEGIN
                    Rec."Marketing Lot No." := '';
                    Rec."Packing By" := '';
                    Rec."Quality Test Date" := 0D;
                    Rec."Expiry Date" := 0D;
                END;
            end;
        }
        field(17; "Packing By"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '//For Packing Stage Only';
        }
        field(18; "Quality Test Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//For Packing Stage Only';

            trigger OnValidate()
            begin
                //for "Expiry Date"
                rec27.RESET;
                IF rec27.GET(Rec."Item No.") THEN BEGIN
                    IF rec27."Class of Seeds" = rec27."Class of Seeds"::TL THEN BEGIN //for Hybrid
                        IF Rec.RVD = FALSE THEN
                            IF Rec."Quality Test Date" <> 0D THEN
                                Rec."Expiry Date" := CALCDATE('<9M>', Rec."Quality Test Date");
                    END;
                END;

                //for RVD
                IF Rec.RVD = TRUE THEN
                    IF Rec."Quality Test Date" <> 0D THEN
                        Rec."Expiry Date" := CALCDATE('<6M>', Rec."Quality Test Date");

                //for blank
                IF Rec."Quality Test Date" = 0D THEN
                    Rec."Expiry Date" := 0D;
            end;
        }
        field(19; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//For Packing Stage Only';
        }
        field(20; "Lint Bin/Stack Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "To Bin/Stack Code"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.TESTFIELD("From Bute No.");
                Rec.TESTFIELD("From Bin/Stack Code");
            end;
        }
        field(25; "Item No."; Code[20])
        {
            Caption = 'Item No.';
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
            CalcFormula = Lookup("Process Header"."To Stage" WHERE("No." = FIELD("Document No.")));
            Description = '//"To Bin/Stack Code"';
            Editable = false;
            FieldClass = FlowField;
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

            trigger OnValidate()
            begin
                Rec.VALIDATE("Process Loss Qty.", (Rec."Required Qty." - (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty.")));
                IF (Rec."Required Qty." < (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty." + Rec."Process Loss Qty.")) THEN
                    ERROR('Quantity taken should not be less than Avai. Quantity.');
            end;
        }
        field(31; "Remenant Bin/Stack Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Location Code"; Code[20])
        {
            CalcFormula = Lookup("Process Header".Location WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
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

            // trigger OnValidate()
            // var
            //     recUL: Record "50015";
            //     ProcessTransferPostYesNo: Codeunit 50000;
            // begin
            // end;
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
            Editable = false;
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

            trigger OnValidate()
            begin
                CountingTotalLabel;
                IF Rec."Label No.-1 From" = 0 THEN
                    IF Rec."Label No.-1 To" = 0 THEN
                        IF Rec."Label No.-2 From" = 0 THEN
                            IF Rec."Label No.-2 To" = 0 THEN
                                IF Rec."Label No.-3 From" = 0 THEN
                                    IF Rec."Label No.-3 To" = 0 THEN
                                        IF Rec."Cancel Label" = '' THEN
                                            CLEAR(Rec."Total Label");
            end;
        }
        field(47; "Label No.-1 To"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';

            trigger OnValidate()
            begin
                CountingTotalLabel;
                IF Rec."Label No.-1 From" = 0 THEN
                    IF Rec."Label No.-1 To" = 0 THEN
                        IF Rec."Label No.-2 From" = 0 THEN
                            IF Rec."Label No.-2 To" = 0 THEN
                                IF Rec."Label No.-3 From" = 0 THEN
                                    IF Rec."Label No.-3 To" = 0 THEN
                                        IF Rec."Cancel Label" = '' THEN
                                            CLEAR(Rec."Total Label");
            end;
        }
        field(48; "Cancel Label"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';

            trigger OnValidate()
            begin
                CountingTotalLabel;
                IF Rec."Label No.-1 From" = 0 THEN
                    IF Rec."Label No.-1 To" = 0 THEN
                        IF Rec."Label No.-2 From" = 0 THEN
                            IF Rec."Label No.-2 To" = 0 THEN
                                IF Rec."Label No.-3 From" = 0 THEN
                                    IF Rec."Label No.-3 To" = 0 THEN
                                        IF Rec."Cancel Label" = '' THEN
                                            CLEAR(Rec."Total Label");
            end;
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

            trigger OnValidate()
            begin
                CountingTotalLabel;
                IF Rec."Label No.-1 From" = 0 THEN
                    IF Rec."Label No.-1 To" = 0 THEN
                        IF Rec."Label No.-2 From" = 0 THEN
                            IF Rec."Label No.-2 To" = 0 THEN
                                IF Rec."Label No.-3 From" = 0 THEN
                                    IF Rec."Label No.-3 To" = 0 THEN
                                        IF Rec."Cancel Label" = '' THEN
                                            CLEAR(Rec."Total Label");
            end;
        }
        field(51; "Label No.-2 To"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';

            trigger OnValidate()
            begin
                CountingTotalLabel;
                IF Rec."Label No.-1 From" = 0 THEN
                    IF Rec."Label No.-1 To" = 0 THEN
                        IF Rec."Label No.-2 From" = 0 THEN
                            IF Rec."Label No.-2 To" = 0 THEN
                                IF Rec."Label No.-3 From" = 0 THEN
                                    IF Rec."Label No.-3 To" = 0 THEN
                                        IF Rec."Cancel Label" = '' THEN
                                            CLEAR(Rec."Total Label");
            end;
        }
        field(52; "Label No.-3 From"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';

            trigger OnValidate()
            begin
                CountingTotalLabel;
                IF Rec."Label No.-1 From" = 0 THEN
                    IF Rec."Label No.-1 To" = 0 THEN
                        IF Rec."Label No.-2 From" = 0 THEN
                            IF Rec."Label No.-2 To" = 0 THEN
                                IF Rec."Label No.-3 From" = 0 THEN
                                    IF Rec."Label No.-3 To" = 0 THEN
                                        IF Rec."Cancel Label" = '' THEN
                                            CLEAR(Rec."Total Label");
            end;
        }
        field(53; "Label No.-3 To"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';

            trigger OnValidate()
            begin
                CountingTotalLabel;
                IF Rec."Label No.-1 From" = 0 THEN
                    IF Rec."Label No.-1 To" = 0 THEN
                        IF Rec."Label No.-2 From" = 0 THEN
                            IF Rec."Label No.-2 To" = 0 THEN
                                IF Rec."Label No.-3 From" = 0 THEN
                                    IF Rec."Label No.-3 To" = 0 THEN
                                        IF Rec."Cancel Label" = '' THEN
                                            CLEAR(Rec."Total Label");
            end;
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
                IF Rec."Sample No. of Bags/Pckt" <> 0 THEN BEGIN
                    //Get Process Header Details
                    recProcessHeader.RESET;
                    IF NOT recProcessHeader.GET(Rec."Document No.") THEN
                        ERROR('Process Header %1 doesnot found.', Rec."Document No.");

                    //Calculate Sample Qty. for Cleaning to Packed Item
                    IF recProcessHeader."To Stage" = 'PACKED' THEN BEGIN
                        Rec.TESTFIELD("Packed Item Code");
                        rec27.RESET;
                        IF NOT rec27.GET(Rec."Packed Item Code") THEN
                            ERROR('Unable to get details of Item No. %1', Rec."Packed Item Code");
                        Rec.VALIDATE("Sample Qty.", (rec27."FG Pack Size" * Rec."Sample No. of Bags/Pckt"));
                        // Rec."Good No. of Bags/Pckt" := Rec."Good No. of Bags/Pckt" - "Sample No. of Bags/Pckt";
                    END;
                END;

                IF Rec."Sample No. of Bags/Pckt" = 0 THEN BEGIN
                    Rec."Sample Qty." := 0;
                    Rec."Good No. of Bags/Pckt" := Rec."Good No. of Bags/Pckt" + xRec."Sample No. of Bags/Pckt";
                END;
            end;
        }
        field(56; "Sample Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = '//For cleanin to pack only';

            trigger OnValidate()
            begin
                //Rec.VALIDATE("Good Qty.",(Rec."Required Qty." - (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty." + Rec."Sample Qty.")));
                Rec.VALIDATE("Process Loss Qty.", "Process Loss Qty." - Rec."Sample Qty.");
                IF (Rec."Total Avai. Qty." < (Rec."Good Qty." + Rec."Lint Qty." + Rec."Remenant Qty." + Rec."Process Loss Qty." + Rec."Sample Qty.")) THEN
                    ERROR('Quantity taken should be less than Avai. Quantity.');
            end;
        }
        field(57; "Sample Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = '//For cleanin to pack only';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            var
                recUL: Record 50015;
                ProcessTransferPostYesNo: Codeunit 50000;
            begin
                "Sample Bin Code" := 'SAMPLE';
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
        field(60; "Crop Code"; Code[20])
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
    }

    var
        rec27: Record 27;
        Item: Record 27;
        BinContent: Record 7302;
    //GerminationEvaluation: Record "50027";

    local procedure CountingTotalLabel()
    var
        Var_Count: Integer;
        Var_CancelLabelCount: Integer;
        Var_CancelLabelText: Text;
    begin
        CLEAR(Var_CancelLabelCount);
        IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) THEN
            Rec.VALIDATE("Total Label", ((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1));
        IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) AND (Rec."Label No.-2 From" <> 0) AND (Rec."Label No.-2 To" <> 0) THEN
            Rec.VALIDATE("Total Label", (((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) + ((Rec."Label No.-2 To" - Rec."Label No.-2 From") + 1)));
        IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) AND (Rec."Label No.-2 From" <> 0) AND (Rec."Label No.-2 To" <> 0) AND (Rec."Label No.-3 From" <> 0) AND (Rec."Label No.-3 To" <> 0) THEN
            Rec.VALIDATE("Total Label", (((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) + ((Rec."Label No.-2 To" - Rec."Label No.-2 From") + 1) + ((Rec."Label No.-3 To" - Rec."Label No.-3 From") + 1)));
        Var_CancelLabelText := Rec."Cancel Label";
        IF Var_CancelLabelText <> '' THEN BEGIN
            FOR Var_Count := 1 TO STRLEN(Var_CancelLabelText) DO BEGIN
                IF STRPOS(Var_CancelLabelText, ',') <> 0 THEN BEGIN
                    Var_CancelLabelCount += 1;
                    IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) THEN
                        Rec.VALIDATE("Total Label", ((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) - Var_CancelLabelCount);
                    IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) AND (Rec."Label No.-2 From" <> 0) AND (Rec."Label No.-2 To" <> 0) THEN
                        Rec.VALIDATE("Total Label", (((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) + ((Rec."Label No.-2 To" - Rec."Label No.-2 From") + 1)) - Var_CancelLabelCount);
                    IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) AND (Rec."Label No.-2 From" <> 0) AND (Rec."Label No.-2 To" <> 0) AND (Rec."Label No.-3 From" <> 0) AND (Rec."Label No.-3 To" <> 0) THEN
                        Rec.VALIDATE("Total Label", (((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) + ((Rec."Label No.-2 To" - Rec."Label No.-2 From") + 1) + ((Rec."Label No.-3 To" - Rec."Label No.-3 From") + 1)) - Var_CancelLabelCount);
                    Var_CancelLabelText := DELSTR(Var_CancelLabelText, 1, STRPOS(Var_CancelLabelText, ','));
                END;
            END;
            IF STRPOS(Var_CancelLabelText, ',') = 0 THEN BEGIN
                Var_CancelLabelCount += 1;
                IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) THEN
                    Rec.VALIDATE("Total Label", ((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) - Var_CancelLabelCount);
                IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) AND (Rec."Label No.-2 From" <> 0) AND (Rec."Label No.-2 To" <> 0) THEN
                    Rec.VALIDATE("Total Label", (((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) + ((Rec."Label No.-2 To" - Rec."Label No.-2 From") + 1)) - Var_CancelLabelCount);
                IF (Rec."Label No.-1 From" <> 0) AND (Rec."Label No.-1 To" <> 0) AND (Rec."Label No.-2 From" <> 0) AND (Rec."Label No.-2 To" <> 0) AND (Rec."Label No.-3 From" <> 0) AND (Rec."Label No.-3 To" <> 0) THEN
                    Rec.VALIDATE("Total Label", (((Rec."Label No.-1 To" - Rec."Label No.-1 From") + 1) + ((Rec."Label No.-2 To" - Rec."Label No.-2 From") + 1) + ((Rec."Label No.-3 To" - Rec."Label No.-3 From") + 1)) - Var_CancelLabelCount);
            END;
        END;
    end;
}

