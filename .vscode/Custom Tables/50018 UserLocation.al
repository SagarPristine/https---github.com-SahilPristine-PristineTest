table 50018 "User Location"
{

    fields
    {
        field(1; "User ID"; Code[30])
        {
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Location Code"; Code[10])
        {
            Editable = true;
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                /*IF LocationRec.GET("Sell-to Customer No.") THEN
                  "Main Location" := LocationRec."Global Dimension 2";*/
                //commented by rakesh

            end;
        }
        field(3; "Create Sales Order"; Boolean)
        {
        }
        field(4; "Transfer From"; Boolean)
        {
        }
        field(5; "Transfer To"; Boolean)
        {
        }
        field(6; "Create Sales Invoice"; Boolean)
        {
        }
        field(7; "View Sales Order"; Boolean)
        {
        }
        field(8; "View Sales Invoice"; Boolean)
        {
        }
        field(9; "Create Sales Credit memo"; Boolean)
        {
        }
        field(10; "Create Sales Blanket Order"; Boolean)
        {
        }
        field(11; "Create Sales Return order"; Boolean)
        {
        }
        field(12; "View Sales Credit memo"; Boolean)
        {
        }
        field(13; "View Sales Blanket Order"; Boolean)
        {
        }
        field(14; "View Sales Return order"; Boolean)
        {
        }
        field(15; "Create Sales Quote"; Boolean)
        {
        }
        field(16; "View Sales Quote"; Boolean)
        {
        }
        field(17; "Create Purchase Order"; Boolean)
        {
            Description = 'InUsed';

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Create Purchase Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Create Purchase Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Create Purchase Order" = TRUE THEN
                    Rec."View Purchase Order" := TRUE
                ELSE
                    Rec."View Purchase Order" := FALSE;

            end;
        }
        field(18; "Create Purchase Invoice"; Boolean)
        {
        }
        field(19; "View Purchase Order"; Boolean)
        {
            Description = 'InUsed';

            trigger OnValidate()
            begin
                IF Rec."Create Purchase Order" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Create Purchase Order"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Create Purchase Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Create Purchase Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(20; "View Purchase Invoice"; Boolean)
        {
        }
        field(21; "Create Purchase Credit memo"; Boolean)
        {
        }
        field(22; "Create Purchase Blanket Order"; Boolean)
        {
        }
        field(23; "Create Purchase Return order"; Boolean)
        {
        }
        field(24; "View Purchase Credit memo"; Boolean)
        {
        }
        field(25; "View Purchase Blanket Order"; Boolean)
        {
        }
        field(26; "View Purchase Return order"; Boolean)
        {
        }
        field(27; "Create Purchase Quote"; Boolean)
        {
        }
        field(28; "View Purchase Quote"; Boolean)
        {
        }
        field(29; "GJT General"; Boolean)
        {
        }
        field(30; "GJT Sales"; Boolean)
        {
        }
        field(31; "GJT Purchases"; Boolean)
        {
        }
        field(32; "GJT Cash Receipts"; Boolean)
        {
        }
        field(33; "GJT Payments"; Boolean)
        {
        }
        field(34; "GJT Assets"; Boolean)
        {
        }
        field(35; "GJT TDS Adjustments"; Boolean)
        {
        }
        field(36; "GJT LC"; Boolean)
        {
        }
        field(37; "GJT Receipts"; Boolean)
        {
        }
        field(38; "GJT JV"; Boolean)
        {
        }
        field(39; "GJT StdPayments"; Boolean)
        {
        }
        field(40; "IJT Item"; Boolean)
        {
        }
        field(41; "IJT Transfer"; Boolean)
        {
        }
        field(42; "IJT Phys. Inventory"; Boolean)
        {
        }
        field(43; "IJT Revaluation"; Boolean)
        {
        }
        field(44; "IJT Consumption"; Boolean)
        {
        }
        field(45; "IJT Output"; Boolean)
        {
        }
        field(46; "IJT Capacity"; Boolean)
        {
        }
        field(47; "Create Indent"; Boolean)
        {
        }
        field(48; "View Indent"; Boolean)
        {
        }
        field(49; "Sales Shipment"; Boolean)
        {
        }
        field(50; Purchaser; Boolean)
        {
        }
        field(51; "RGP IN"; Boolean)
        {
        }
        field(52; "RGP OUT"; Boolean)
        {
        }
        field(53; "View Export Order"; Boolean)
        {
        }
        field(54; "Create Export Order"; Boolean)
        {
        }
        field(55; "Main Location"; Code[10])
        {
            Editable = false;
        }
        field(56; "View Import Order"; Boolean)
        {
        }
        field(57; "Create Import Order"; Boolean)
        {
        }
        field(58; "Purchase Receipt"; Boolean)
        {
        }
        field(59; "Sales Invoice"; Boolean)
        {
        }
        field(60; "Sales Credit Memo"; Boolean)
        {
        }
        field(61; "Sales Return Shipment"; Boolean)
        {
        }
        field(62; "Purchase Invoice"; Boolean)
        {
        }
        field(63; "Purchase Credit Memo"; Boolean)
        {
        }
        field(64; "Purchase Return Shipment"; Boolean)
        {
        }
        field(65; "Archive Requisition"; Boolean)
        {
        }
        field(66; "View Purchase Receipt"; Boolean)
        {
        }
        field(67; "Posted Transfer Shipment"; Boolean)
        {
        }
        field(68; "Posted Transfer Receipts"; Boolean)
        {
        }
        field(69; "Change Dim. For TO"; Boolean)
        {
        }
        field(70; "View Transfer Shipment"; Boolean)
        {
        }
        field(71; "View Transfer Receipt"; Boolean)
        {
        }
        field(72; "Create Transfer Order"; Boolean)
        {
        }
        field(73; BomJnl; Boolean)
        {
        }
        field(74; "Post Credit Memo"; Boolean)
        {
            Description = 'Do not delete-- IMP';
        }
        field(75; "Damage Stock Authority"; Boolean)
        {
            Description = '';
        }
        field(76; "Sales Order Reopen"; Boolean)
        {
        }
        field(77; "Cancel Reservation"; Boolean)
        {
        }
        field(78; "Purchase Order Released"; Boolean)
        {
        }
        field(79; "Released P.O."; Boolean)
        {
        }
        field(80; "Grower Master"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//AjeetSeed Column Start from Here';

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Grower Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Grower Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Grower Master" = TRUE THEN
                    Rec."View Grower Master" := TRUE
                ELSE
                    Rec."View Grower Master" := FALSE;

            end;
        }
        field(81; "Process Header"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Process Header" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Process Header"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

                IF Rec."Process Header" = TRUE THEN BEGIN
                    Rec."Process Invoice Header" := TRUE;
                    Rec."Got Testing Master" := TRUE;
                    Rec."BT Testing Master" := TRUE;
                    Rec."Germination Determination" := TRUE;
                    Rec."Physical Purity Determination" := TRUE;
                    Rec."Moisture Determination" := TRUE;
                    Rec."Vigour Test" := TRUE;
                    Rec."QC Result Declaration" := TRUE;
                    Rec."View Process Header" := TRUE;
                    Rec."View Process Invoice Header" := TRUE;
                    Rec."View Got Testing Master" := TRUE;
                    Rec."View BT Testing Master" := TRUE;
                    Rec."View Germination Determination" := TRUE;
                    Rec."View Physical Purity Deter." := TRUE;
                    Rec."View Moisture Determination" := TRUE;
                    Rec."View Vigour Test" := TRUE;
                    Rec."View QC Result Declaration" := TRUE;
                END ELSE BEGIN
                    Rec."Process Invoice Header" := FALSE;
                    Rec."Got Testing Master" := FALSE;
                    Rec."BT Testing Master" := FALSE;
                    Rec."View Process Header" := FALSE;
                    Rec."Germination Determination" := FALSE;
                    Rec."Physical Purity Determination" := FALSE;
                    Rec."Moisture Determination" := FALSE;
                    Rec."Vigour Test" := FALSE;
                    Rec."QC Result Declaration" := FALSE;
                    Rec."View Process Invoice Header" := FALSE;
                    Rec."View Got Testing Master" := FALSE;
                    Rec."View BT Testing Master" := FALSE;
                    Rec."View Germination Determination" := FALSE;
                    Rec."View Physical Purity Deter." := FALSE;
                    Rec."View Moisture Determination" := FALSE;
                    Rec."View Vigour Test" := FALSE;
                    Rec."View QC Result Declaration" := FALSE;
                END;

            end;
        }
        field(82; "Process Invoice Header"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(83; "Planting List"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Planting List" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Planting List"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Planting List" = TRUE THEN
                    Rec."View Planting List" := TRUE
                ELSE
                    Rec."View Planting List" := FALSE;

            end;
        }
        field(88; "Org Gate Entry Outward"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Org Gate Entry Outward" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Org Gate Entry Outward"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Org Gate Entry Outward" = TRUE THEN
                    Rec."View Org Gate Entry Outward" := TRUE
                ELSE
                    Rec."View Org Gate Entry Outward" := FALSE;

            end;
        }
        field(89; "Got Testing Master"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "BT Testing Master"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Retest Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Retest Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Retest Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Retest Master" = TRUE THEN
                    Rec."View Retest Master" := TRUE
                ELSE
                    Rec."View Retest Master" := FALSE;

            end;
        }
        field(92; Blend; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.Blend = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(Blend),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec.Blend = TRUE THEN
                    Rec."View Blend" := TRUE
                ELSE
                    Rec."View Blend" := FALSE;

            end;
        }
        field(93; BSIO; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.BSIO = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(BSIO),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec.BSIO = TRUE THEN
                    Rec."View BSIO" := TRUE
                ELSE
                    Rec."View BSIO" := FALSE;

            end;
        }
        field(94; FSIO; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.FSIO = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(FSIO),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec.FSIO = TRUE THEN
                    Rec."View FSIO" := TRUE
                ELSE
                    Rec."View FSIO" := FALSE;

            end;
        }
        field(95; "Seed Arrival FSIO"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Seed Arrival FSIO" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Seed Arrival FSIO"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Seed Arrival FSIO" = TRUE THEN
                    Rec."View Seed Arrival FSIO" := TRUE
                ELSE
                    Rec."View Seed Arrival FSIO" := FALSE;

            end;
        }
        field(96; "Seed Arrival Hybrid"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Seed Arrival Hybrid" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Seed Arrival Hybrid"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Seed Arrival Hybrid" = TRUE THEN
                    Rec."View Seed Arrival Hybrid" := TRUE
                ELSE
                    Rec."View Seed Arrival Hybrid" := FALSE;

            end;
        }
        field(97; "View Grower Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Grower Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Grower Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Grower Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Grower Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(98; "View Process Header"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Process Header" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Process Header"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Process Header" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Process Header"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(99; "View Process Invoice Header"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                IF Rec."Process Invoice Header" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Process Invoice Header"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Process Invoice Header" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Process Invoice Header"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(100; "View Planting List"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Planting List" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Planting List"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Planting List" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Planting List"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }

        field(105; "View Org Gate Entry Outward"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Org Gate Entry Outward" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Org Gate Entry Outward"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Org Gate Entry Outward" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Org Gate Entry Outward"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(106; "View Got Testing Master"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                IF Rec."Got Testing Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Got Testing Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Got Testing Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Got Testing Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(107; "View BT Testing Master"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                IF Rec."BT Testing Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("BT Testing Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View BT Testing Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View BT Testing Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(108; "View Retest Master"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                IF Rec."Retest Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Retest Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Retest Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Retest Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(109; "View Blend"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec.Blend = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION(Blend));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.Blend = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(Blend),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(110; "View BSIO"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec.BSIO = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION(BSIO));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.BSIO = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(BSIO),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(111; "View FSIO"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec.FSIO = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION(FSIO));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.FSIO = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(FSIO),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(112; "View Seed Arrival FSIO"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Seed Arrival FSIO" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Seed Arrival FSIO"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Seed Arrival FSIO" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Seed Arrival FSIO"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(113; "View Seed Arrival Hybrid"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Seed Arrival Hybrid" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Seed Arrival Hybrid"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Seed Arrival Hybrid" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Seed Arrival Hybrid"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(114; "Gate Entry Inward"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Gate Entry Inward" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Gate Entry Inward"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Gate Entry Inward" = TRUE THEN
                    Rec."View Gate Entry Inward" := TRUE
                ELSE
                    Rec."View Gate Entry Inward" := FALSE;

            end;
        }
        field(115; "Gate Entry Outward"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Gate Entry Outward" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Gate Entry Outward"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Gate Entry Outward" = TRUE THEN
                    Rec."View Gate Entry Outward" := TRUE
                ELSE
                    Rec."View Gate Entry Outward" := FALSE;

            end;
        }
        field(116; "View Gate Entry Inward"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Gate Entry Inward" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Gate Entry Inward"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Gate Entry Inward" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Gate Entry Inward"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(117; "View Gate Entry Outward"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Gate Entry Outward" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Gate Entry Outward"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Gate Entry Outward" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Gate Entry Outward"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(118; "Crop Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Crop Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Crop Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Crop Master" = TRUE THEN
                    Rec."View Crop Master" := TRUE
                ELSE
                    Rec."View Crop Master" := FALSE;

            end;
        }
        field(119; "Crop Stage Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Crop Stage Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Crop Stage Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Crop Stage Master" = TRUE THEN
                    Rec."View Crop Stage Master" := TRUE
                ELSE
                    Rec."View Crop Stage Master" := FALSE;

            end;
        }
        field(120; "Season Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Season Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Season Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Season Master" = TRUE THEN
                    Rec."View Season Master" := TRUE
                ELSE
                    Rec."View Season Master" := FALSE;

            end;
        }
        field(121; "Item Group Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Item Group Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Item Group Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Item Group Master" = TRUE THEN
                    Rec."View Item Group Master" := TRUE
                ELSE
                    Rec."View Item Group Master" := FALSE;

            end;
        }
        field(122; "Geographical Setup"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Geographical Setup" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Geographical Setup"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Geographical Setup" = TRUE THEN
                    Rec."View Geographical Setup" := TRUE
                ELSE
                    Rec."View Geographical Setup" := FALSE;

            end;
        }
        field(123; "Party Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Party Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Party Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Party Master" = TRUE THEN
                    Rec."View Party Master" := TRUE
                ELSE
                    Rec."View Party Master" := FALSE;

            end;
        }
        field(124; "Zone Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Zone Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Zone Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Zone Master" = TRUE THEN
                    Rec."View Zone Master" := TRUE
                ELSE
                    Rec."View Zone Master" := FALSE;

            end;
        }
        field(125; "Taluka Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Taluka Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Taluka Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Taluka Master" = TRUE THEN
                    Rec."View Taluka Master" := TRUE
                ELSE
                    Rec."View Taluka Master" := FALSE;

            end;
        }
        field(126; "Region Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Region Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Region Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Region Master" = TRUE THEN
                    Rec."View Region Master" := TRUE
                ELSE
                    Rec."View Region Master" := FALSE;

            end;
        }
        field(127; "District Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."District Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("District Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."District Master" = TRUE THEN
                    Rec."View District Master" := TRUE
                ELSE
                    Rec."View District Master" := FALSE;

            end;
        }
        field(128; "Parent Seed Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Parent Seed Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Parent Seed Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Parent Seed Master" = TRUE THEN
                    Rec."View Parent Seed Master" := TRUE
                ELSE
                    Rec."View Parent Seed Master" := FALSE;

            end;
        }
        field(129; "Lot Range Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Lot Range Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Lot Range Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Lot Range Master" = TRUE THEN
                    Rec."View Lot Range Master" := TRUE
                ELSE
                    Rec."View Lot Range Master" := FALSE;

            end;
        }
        field(130; "View Crop Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Crop Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Crop Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Crop Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Crop Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(131; "View Crop Stage Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Crop Stage Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Crop Stage Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Crop Stage Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Crop Stage Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(132; "View Season Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Season Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Season Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Season Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Season Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(133; "View Item Group Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Item Group Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Item Group Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Item Group Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Item Group Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(134; "View Geographical Setup"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Geographical Setup" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Geographical Setup"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Geographical Setup" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Geographical Setup"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(135; "View Party Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Party Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Party Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Party Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Party Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(136; "View Zone Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Zone Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Zone Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Zone Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Zone Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(137; "View Taluka Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Taluka Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Taluka Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Taluka Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Taluka Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(138; "View Region Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Region Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Region Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Region Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Region Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(139; "View District Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."District Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("District Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View District Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View District Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(140; "View Parent Seed Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Parent Seed Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Parent Seed Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Parent Seed Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Parent Seed Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(141; "View Lot Range Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Lot Range Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Lot Range Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Lot Range Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Lot Range Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(142; "State Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."State Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("State Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."State Master" = TRUE THEN
                    Rec."View State Master" := TRUE
                ELSE
                    Rec."View State Master" := FALSE;

            end;
        }
        field(143; "View State Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."State Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("State Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View State Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View State Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(144; "Location Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Location Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Location Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Location Master" = TRUE THEN
                    Rec."View Location Master" := TRUE
                ELSE
                    Rec."View Location Master" := FALSE;

            end;
        }
        field(145; "View Location Master"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Location Master" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Location Master"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Location Master" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Location Master"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(146; "Germination Determination"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(147; "Physical Purity Determination"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(148; "Moisture Determination"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(149; "Vigour Test"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(150; "View Germination Determination"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Germination Determination" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Germination Determination"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Germination Determination" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Germination Determination"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(151; "View Physical Purity Deter."; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Physical Purity Determination" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Physical Purity Determination"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Physical Purity Deter." = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Physical Purity Deter."),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(152; "View Moisture Determination"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Moisture Determination" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Moisture Determination"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Moisture Determination" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Moisture Determination"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(153; "View Vigour Test"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Vigour Test" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Vigour Test"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Vigour Test" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Vigour Test"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(154; "QC Result Declaration"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."QC Result Declaration" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("QC Result Declaration"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."QC Result Declaration" = TRUE THEN
                    Rec."View QC Result Declaration" := TRUE
                ELSE
                    Rec."View QC Result Declaration" := FALSE;

            end;
        }
        field(155; "View QC Result Declaration"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."QC Result Declaration" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("QC Result Declaration"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View QC Result Declaration" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View QC Result Declaration"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(156; "Organizer Arrival"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Organizer Arrival" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Organizer Arrival"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Organizer Arrival" = TRUE THEN
                    Rec."View Organizer Arrival" := TRUE
                ELSE
                    Rec."View Organizer Arrival" := FALSE;

            end;
        }
        field(157; "View Organizer Arrival"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Organizer Arrival" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Organizer Arrival"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Organizer Arrival" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Organizer Arrival"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(158; "Organizer Process Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Organizer Process Transfer" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Organizer Process Transfer"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Organizer Process Transfer" = TRUE THEN
                    Rec."View Organizer Process Trnsfr" := TRUE
                ELSE
                    Rec."View Organizer Process Trnsfr" := FALSE;

            end;
        }
        field(159; "View Organizer Process Trnsfr"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Organizer Process Transfer" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Organizer Process Transfer"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Organizer Process Trnsfr" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Organizer Process Trnsfr"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(160; "Delivery Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Delivery Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Delivery Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Delivery Order" = TRUE THEN
                    Rec."View Delivery Order" := TRUE
                ELSE
                    Rec."View Delivery Order" := FALSE;

            end;
        }
        field(161; "View Delivery Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Delivery Order" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Delivery Order"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Delivery Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Delivery Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(162; "Marketing Indent"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Marketing Indent" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Marketing Indent"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Marketing Indent" = TRUE THEN
                    Rec."View Marketing Indent" := TRUE
                ELSE
                    Rec."View Marketing Indent" := FALSE;

            end;
        }
        field(163; "View Marketing Indent"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Marketing Indent" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Marketing Indent"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Marketing Indent" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Marketing Indent"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(164; "Hybrid Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Hybrid Sales Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Hybrid Sales Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Hybrid Sales Order" = TRUE THEN
                    Rec."View Hybrid Sales Order" := TRUE
                ELSE
                    Rec."View Hybrid Sales Order" := FALSE;

            end;
        }
        field(165; "View Hybrid Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Hybrid Sales Order" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Hybrid Sales Order"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Hybrid Sales Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Hybrid Sales Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(166; Cartage; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.Cartage = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(Cartage),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec.Cartage = TRUE THEN
                    Rec."View Cartage" := TRUE
                ELSE
                    Rec."View Cartage" := FALSE;

            end;
        }
        field(167; "View Cartage"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec.Cartage = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION(Cartage));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.Cartage = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(Cartage),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(168; "Non Seed Indent"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Non Seed Indent" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Non Seed Indent"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Non Seed Indent" = TRUE THEN
                    Rec."View Non Seed Indent" := TRUE
                ELSE
                    Rec."View Non Seed Indent" := FALSE;

            end;
        }
        field(169; "View Non Seed Indent"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Non Seed Indent" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Non Seed Indent"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Non Seed Indent" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Non Seed Indent"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(170; "View Posted BSIO"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Posted BSIO" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Posted BSIO"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(171; "View Posted FSIO"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Posted FSIO" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Posted FSIO"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(172; "View Posted Hybrid Sales Ordr"; Boolean)
        {
            Caption = 'View Posted Hybrid Sales Order';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Posted Hybrid Sales Ordr" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Posted Hybrid Sales Ordr"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(173; "View Posted Seed Arrival"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View Posted FSIO" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View Posted FSIO"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(174; "View Posted Planting List"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(175; "View Posted Hybrid Seed Arrvl"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(176; "View Posted Nursery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(177; "View Posted Vegetative"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(178; "View Posted Isolation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(179; "View Posted Pre Flowering"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(180; "View Posted Got"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(181; "View Posted BT/Elisa"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(182; "View Posted Blend"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(183; "View Posted Germination Deter."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(184; "View Posted PPD"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(185; "View Posted Moisture Deter."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(186; "View Posted Vigour Test"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(187; "View Posted QC Declara."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(188; "View Posted Retest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(189; "View Posted Org. Arrival"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(190; "View Posted Org. Process Trnfr"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(191; "View Posted Org. OGE"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(192; "View Posted Marketing Indent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(193; "View Posted Delivery Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(194; "View Posted Cartage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(195; "View Posted Non Seed Indent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(196; RVD; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.RVD = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(RVD),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec.RVD = TRUE THEN
                    Rec."View RVD" := TRUE
                ELSE
                    Rec."View RVD" := FALSE;

            end;
        }
        field(198; "View RVD"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec.RVD = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION(RVD));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.RVD = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(RVD),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(199; "View Posted RVD"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(200; "App Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."App Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("App Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."App Order" = TRUE THEN
                    Rec."View App Order" := TRUE
                ELSE
                    Rec."View App Order" := FALSE;

            end;
        }
        field(201; "View App Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."App Order" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("App Order"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."App Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("App Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(202; "View Posted App Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(203; "App Event"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."App Event" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("App Event"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."App Event" = TRUE THEN
                    Rec."View App Event" := TRUE
                ELSE
                    Rec."View App Event" := FALSE;

            end;
        }
        field(204; "View App Event"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."App Event" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("App Event"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."App Event" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("App Event"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(205; "View Posted App Event"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(206; "App Travel"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."App Travel" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("App Travel"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."App Travel" = TRUE THEN
                    Rec."View App Travel" := TRUE
                ELSE
                    Rec."View App Travel" := FALSE;

            end;
        }
        field(207; "View App Travel"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."App Travel" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("App Travel"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."App Travel" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("App Travel"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(208; "View Posted App Travel"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(209; "Sucker Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Sucker Receipt" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Sucker Receipt"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Sucker Receipt" = TRUE THEN
                    Rec."View Sucker Receipt" := TRUE
                ELSE
                    Rec."View Sucker Receipt" := FALSE;

            end;
        }
        field(210; "View Sucker Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Sucker Receipt" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Sucker Receipt"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Sucker Receipt" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Sucker Receipt"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(211; "View Posted Sucker Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(214; "View Posted Tissue Culture PT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(217; "View Posted Tissue Culture Ct."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(218; "Location Name"; Text[100])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(222; "Post Non Seed Indent"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Post Non Seed Indent" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Post Non Seed Indent"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(223; "Location Code 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                /*IF LocationRec.GET("Sell-to Customer No.") THEN
                  "Main Location" := LocationRec."Global Dimension 2";*/
                //commented by rakesh

            end;
        }
        field(224; "Location Name 2"; Text[100])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Location Code 2")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(225; "Can Access All Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(226; RIB; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.RIB = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(RIB),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec.RIB = TRUE THEN
                    Rec."View RIB" := TRUE
                ELSE
                    Rec."View RIB" := FALSE;

            end;
        }
        field(227; "View RIB"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec.RIB = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION(RIB));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.RIB = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(RIB),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(228; "Land Lease"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Land Lease" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Land Lease"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Land Lease" = TRUE THEN
                    Rec."View Land Lease" := TRUE
                ELSE
                    Rec."View Land Lease" := FALSE;

            end;
        }
        field(229; "View Land Lease"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Land Lease" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Land Lease"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Land Lease" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Land Lease"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(230; "Transfer Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Transfer Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Transfer Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec."Transfer Order" = TRUE THEN
                    Rec."View Transfer Order" := TRUE
                ELSE
                    Rec."View Transfer Order" := FALSE;

            end;
        }
        field(231; "View Transfer Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Transfer Order" = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION("Transfer Order"));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."Transfer Order" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("Transfer Order"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(232; VWQP; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Variety Wise Quality Parameter';

            trigger OnValidate()
            begin
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL.VWQP = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION(VWQP),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/
                IF Rec.VWQP = TRUE THEN
                    Rec."View VWQP" := TRUE
                ELSE
                    Rec."View VWQP" := FALSE;

            end;
        }
        field(233; "View VWQP"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Variety Wise Quality Parameter';

            trigger OnValidate()
            begin
                IF Rec.VWQP = TRUE THEN
                    ERROR(ErrorCreationTick, Rec.FIELDCAPTION(VWQP));
                //Check already exist or not
                /*recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID",Rec."User ID");
                IF recUL.FINDSET THEN BEGIN
                  REPEAT
                    IF recUL."Location Code" <> Rec."Location Code" THEN
                      IF recUL."View VWQP" = TRUE THEN
                        ERROR(ErrorAlreadyTickAtDiffLocation,Rec.FIELDCAPTION("View VWQP"),recUL."Location Code");
                  UNTIL recUL.NEXT = 0;
                END;*/

            end;
        }
        field(234; NAOH; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(235; EC; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(236; "Chlorophyll Test"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(237; "Soil Emergence"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(238; AAT; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(239; "HT herbicide tolerance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(240; "Phenol Test"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(241; Inspection; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "User ID", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //IF USERID <> 'TEST' THEN
        //ERROR('User %1 doesnot have permission to edit record.',USERID);
    end;

    var
        LocationRec: Record 14;
        salesheader: Record 36;
        recUL: Record 50018;
        ErrorCreationTick: Label 'You cannot Un-Tick it. Because %1 Creation is Tick.';
        ErrorAlreadyTickAtDiffLocation: Label 'You cannot do %1 TRUE at different Location. Already tick at Location %2.';
}

