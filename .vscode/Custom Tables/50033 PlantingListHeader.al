table 50033 "Planting List Header"
{
    LookupPageID = 50031;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            var
                recul: Record "User Location";
                recloc: Record Location;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE("Planting List", TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("Planting No. Series");
                            NoSeriesMgt.TestManual(recLoc."Planting No. Series");
                            "No. Series" := '';
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Planting No. Series"));
                    END ELSE
                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                END;
            end;
        }
        field(2; Season; Code[20])
        {
            TableRelation = "Season Master"."Season Code";

            trigger OnValidate()
            var
                recSeason: Record "Season Master";
            begin

            end;
        }

        field(4; "Production Centre"; Code[20])
        {
            Caption = 'Production Centre/Location Code';
            TableRelation = Location.Code;

            trigger OnValidate()
            var
                ProcessTransferPostYesNo: Codeunit 50000;
                recLoc: Record Location;
            begin

                IF recLoc.GET("Production Centre") THEN
                    Rec."Production Centre Name" := recLoc.Name
                ELSE
                    Rec."Production Centre Name" := '';
            end;
        }
        field(5; "Production Centre Name"; Text[120])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Production Centre")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Dist; Code[20])
        {
        }
        field(7; Village; Text[30])
        {
        }
        field(8; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(9; "State Code"; Code[10])
        {
            TableRelation = State;
        }
        field(10; Country; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(11; "No. Series"; Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(13; Taluka; Text[80])
        {
            TableRelation = "Taluka Master";
        }
        field(14; District; Text[80])
        {
            TableRelation = "District Master";
        }
        field(15; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(16; "Contract No."; Code[20])
        {
        }
        field(17; Posted; Boolean)
        {
        }
        field(18; Date; Date)
        {
        }
        field(19; Status; Option)
        {
            OptionMembers = Open,Release,Posted;
        }
        field(20; "Organiser Code"; Code[20])
        {
            Caption = 'Organiser/Co-ordinator Code';
            TableRelation = Customer WHERE("Customer Type" = FILTER(Organizer | Grower | Contractor));
        }
        field(21; Type; Option)
        {
            OptionMembers = "Non-Certified",Certified;
        }
        field(22; "Inspection I"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Not Used';
            Editable = false;
        }
        field(23; "Inspection II"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Not Used';
            Editable = false;
        }
        field(24; "Inspection III"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Not Used';
            Editable = false;
        }
        field(25; "Inspection IV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Not Used';
            Editable = false;
        }
        field(26; "Stage Code"; Option)
        {
            Caption = 'Stage Code';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,RAW,GINNED,DINT,GRADED,TREATED';
            OptionMembers = " ",RAW,GIN,DINT,PROCESS,CLEANING;
        }
        field(27; "Inspection QC"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Not Used';
            Editable = false;
        }
        field(28; "Total Sowing Area In R"; Decimal)
        {
            CalcFormula = Sum("Planting List Line"."Sowing Area In R" WHERE("Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Total Land in R"; Decimal)
        {
            CalcFormula = Sum("Sales Shipment Line"."Land in Acre" WHERE("Document No." = FIELD("FSIO No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "FSIO No."; Code[20])
        {
            Caption = 'FSIO No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Header"."No." WHERE("Document SubType" = FILTER(FSIO | BSIO),
                                                               "Sell-to Customer No." = FIELD("Organiser Code"));
        }
        field(31; "Organizer Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Organiser Code")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        // field(32; "FSIO Child No."; Code[20])
        // {
        //     CalcFormula = Lookup("Sales Shipment Header"."Child Seed" WHERE("No." = FIELD("FSIO No.")));
        //     Caption = 'FSIO Child No.';
        //     Editable = false;
        //     FieldClass = FlowField;

        //     trigger OnValidate()
        //     var
        //         rec50017: Record 50017;
        //         SalesShipmentHeader: Record 110;
        //         recSIL: Record 113;
        //         rec50018: Record 50018;
        //         recParentSeedMaster: Record 50009;
        //     begin
        //     end;
        // }
        // field(33; "FSIO Child Name"; Text[100])
        // {
        //     CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("FSIO Child No.")));
        //     Caption = 'FSIO Child Name';
        //     Editable = false;
        //     FieldClass = FlowField;

        //     trigger OnValidate()
        //     var
        //         rec50017: Record 50017;
        //         SalesShipmentHeader: Record 110;
        //         recSIL: Record 113;
        //         rec50018: Record 50018;
        //         recParentSeedMaster: Record 50009;
        //     begin
        //     end;
        // }
        field(35; "BSIO No."; Code[20])
        {
            Caption = 'BSIO No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Header"."No." WHERE("Document SubType" = FILTER(FSIO | BSIO),
                                                               "Sell-to Customer No." = FIELD("Organiser Code"));

            trigger OnValidate()
            var
                rec50017: Record 50017;
                SalesShipmentHeader: Record 110;
                recSIL: Record 113;
                rec50018: Record 50018;
                recParentSeedMaster: Record 50009;
            begin
            end;
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
        fieldgroup(DropDown; "No.", Season, "Production Centre")
        {
        }
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
            recUL.SETRANGE("Planting List", TRUE);
            recul.SetRange("Location Code", "Production Centre");
            IF recUL.FINDFIRST THEN BEGIN
                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                    recLoc.TESTFIELD("Planting No. Series");
                    NoSeriesMgt.InitSeries(recLoc."Planting No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Planting No. Series"));
            END ELSE
                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
        END;
    end;

    trigger OnModify()
    begin
        IF Status = Status::Release THEN
            ERROR('You cannot change after document Release');
    end;

    var
        FieldProdSetup: Record 50008;
        NoSeries: Record 308;
        SowingHeader: Record 50017;
        FSIOHeader: Record 36;
        SowingReportLine: Record 50018;
        SowingReportLine1: Record 50018;
        Con_G_001: Label 'Do you want to Post Planting List?';
        HPLotLoc: Code[30];
        HSPLotSea: Code[30];
        Item: Record 27;
        HSPLotVar: Code[30];
        FSCode: Code[30];
        AvailableLot: Code[30];
        LotNo: Code[30];
        Con_G_002: Label 'Do you want to create lot no.';
        StartCount: Integer;
        Endno: Integer;
        ReceiptValue: Integer;
        NextLineNo: Integer;
        linecount: Integer;
        ReceiptNos: Code[30];
        Text011: Label 'Creating Lot   #2#####';
        Window: Dialog;
        Lotline: Record 50003;
        Lot: Record 50002;
        Season: Record 50009;
        "------------------------------Nakul----------------": Text;
        NoSeriesMgt: Codeunit 396;
        recUL: Record 50015;
        recLoc: Record 14;
        ORGCode: Code[10];

    procedure TestNoSeries(): Boolean
    begin
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        //EXIT(FieldProdSetup.Sowing No. Series);
    end;

    procedure PostSowingReport()
    PlantingListLine: Record "Planting List Line";
    begin
        //checking details
        PlantingListLine.RESET;
        PlantingListLine.SETRANGE("Document No.");
        PlantingListLine.SETRANGE("Document No.", "No.");
        if PlantingListLine.FINDSET THEN BEGIN
            REPEAT
                PlantingListLine.TESTFIELD("Crop Code");
                PlantingListLine.TestField("BSIO No.");
                PlantingListLine.TESTFIELD("Grower Owner");
                PlantingListLine.TESTFIELD("Variety Code");
                PlantingListLine.TESTFIELD("Production Lot No.");
            UNTIL PlantingListLine.NEXT = 0;
        END;

        IF NOT CONFIRM(Con_G_001, FALSE) THEN
            EXIT
        ELSE BEGIN
            TESTFIELD("No.");
            TESTFIELD(rec.Season);
            TESTFIELD(Date);
            TESTFIELD(Status, Status::Open);
            Posted := TRUE;
            Status := Status::Posted;
            MODIFY;
            PlantingListLine.RESET;
            PlantingListLine.SETRANGE("Document No.");
            PlantingListLine.SETRANGE("Document No.", "No.");
            if PlantingListLine.FINDSET THEN BEGIN
                REPEAT
                    PlantingListLine.Posted := TRUE;
                    PlantingListLine.MODIFY;
                UNTIL PlantingListLine.NEXT = 0;
            END;
        END;
    end;

    procedure CreateProductionLotNo(VAR RecsowingHeader: Record "Planting List Header")
    var
        SowingReportLine: Record "Planting List Line";
        PlantingListLine2: Record "Planting List Line" temporary;
        Text00001: TextConst ENU = 'Do you want to create lot no.', DAN = 'Do you want to create lot no.';
        InputDate: Date;
        Year: Integer;
        LotNoNeedtoupdated: Code[20];
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
        IF NOT CONFIRM(Text00001, FALSE) THEN
            EXIT;
        PurchPayablesSetup.Get();
        SowingReportLine.RESET;
        SowingReportLine.SETCURRENTKEY("Document No.", "Receipt Ceated");
        SowingReportLine.SETRANGE("Document No.", RecsowingHeader."No.");
        SowingReportLine.SETRANGE("Receipt Ceated", FALSE);
        IF SowingReportLine.FINDFIRST THEN BEGIN
            REPEAT
                InputDate := TODAY;
                Year := DATE2DMY(InputDate, 3);
                LotNoNeedtoupdated := COPYSTR(FORMAT(rec.Season), STRLEN(FORMAT(rec.Season)) - 2, STRLEN(FORMAT(rec.Season))) + COPYSTR(FORMAT(rec."Organiser Code"), STRLEN(FORMAT(rec."Organiser Code")) - 2, STRLEN(FORMAT(rec."Organiser Code"))) + Format(PurchPayablesSetup."Production Lot indicator");
                SowingReportLine."Production Lot No." := LotNoNeedtoupdated;
                PurchPayablesSetup."Production Lot indicator" := incstr(PurchPayablesSetup."Production Lot indicator");
                PurchPayablesSetup.Modify();
                SowingReportLine.MODIFY;
            UNTIL SowingReportLine.NEXT = 0;
        END;
        SowingReportLine.RESET;
        SowingReportLine.SETCURRENTKEY("Document No.", "Receipt Ceated");
        SowingReportLine.SETRANGE("Document No.", RecsowingHeader."No.");
        SowingReportLine.SETRANGE("Receipt Ceated", FALSE);
        SowingReportLine.MODIFYALL("Receipt Ceated", TRUE);
        if LotNoNeedtoupdated <> '' then
            MESSAGE('Production Lots have been assigned');
    end;

}

